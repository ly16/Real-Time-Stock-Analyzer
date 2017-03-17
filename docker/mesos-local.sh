#!/bin/bash

#
# - colors
#
CYAN='\033[0;36m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No color

print() {
  echo -e "${CYAN}$1${NC}" > $OUTPUT
}

print_err() {
  echo -e "${CYAN}$1${NC}" > /dev/stderr
}

print_title() {
  echo -e "-------------------------------------------" > $OUTPUT
  print "$1"
  >&2 echo -e "-------------------------------------------" > $OUTPUT
}

print_error() {
  echo -e "${RED}$1${NC}" > $OUTPUT
}

OUTPUT=/dev/null
MACHINE_NAME=default
ENV=false

#
# - prep a few variables
# - setup an exit trap
#
BOX=${BOX:-"$MACHINE_NAME"}
PREFIX=${PREFIX:-"ctr"}

docker-machine status $BOX &> /dev/null
if [ $? -ne 0 ]; then
  print_error "docker-machine $BOX is not running"
  exit
fi

BOX_IP=`docker-machine ip $BOX`
TMP="/tmp/ctr-local-stack.$$"
mkdir $TMP
function cleanup {
    rm -rf $TMP
}
trap cleanup EXIT

#
# - prep the mesos-dns configuration file
#
cat << EOM > "$TMP/mesos-dns.json"
{
  "zk":             "zk://${BOX_IP}:2181/mesos",
  "masters":        ["${BOX_IP}:5050"],
  "refreshSeconds": 60,
  "ttl":            60,
  "domain":         "mesos",
  "port":           53,
  "resolvers":      ["8.8.8.8", "8.8.4.4"],
  "timeout":        5,
  "httpon":         true,
  "dnson":          true,
  "httpport":       8123,
  "externalon":     true,
  "SOAMname":       "ns1.mesos",
  "SOARname":       "root.ns1.mesos",
  "SOARefresh":     60,
  "SOARetry":       600,
  "SOAExpire":      86400,
  "SOAMinttl":      60,
  "IPSources":      ["mesos", "host"]
}
EOM

#
# - prep /etc/resolv.conf pointing to the mesos-dns nameserver
#
cat << EOM > "$TMP/resolv.conf"
nameserver ${BOX_IP}
nameserver 10.0.2.3
options rotate
options timeout:1
EOM


#
# active the correct docker-machine and ensure that quay.io can be used
#
print_title "configuring docker-machine $BOX..."
eval $(docker-machine env $BOX)

#
# - make sure to clean stuff up otherwise we may end up failing to run
#   containers (which then may ripple and prevent for instance marathon to
#    start)
#
print_title "cleaning the VM up"
docker rm -f $(docker ps -a -q)
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")

#
# - run a single zookeeper broker
# - clamp to version 3.4.6-cp1
#
print_title "setting up ZooKeeper..."
RUNNING=$(docker inspect --format="{{ .State.Running }}" ${PREFIX}-zookeeper)
if [[ $? -eq 1 ]]; then
docker run -d                                                             \
  --name ${PREFIX}-zookeeper                                              \
  -p 2181:2181                                                            \
  -p 2888:2888                                                            \
  -p 3888:3888                                                            \
  confluent/zookeeper:3.4.6-cp1
elif [[ ${RUNNING} == "false" ]]; then
docker start ${PREFIX}-zookeeper
fi

#
# - run the mesos master
# - clamp to version 0.28.0-2.0.16.ubuntu1404
#
print_title "setting up Mesos master..."
RUNNING=$(docker inspect --format="{{ .State.Running }}" ${PREFIX}-master)
if [[ $? -eq 1 ]]; then
docker run -d                                                             \
  --net="host"                                                            \
  --name ${PREFIX}-master                                                 \
  -p 5050:5050                                                            \
  -e "MESOS_HOSTNAME=${BOX_IP}"                                           \
  -e "MESOS_IP=${BOX_IP}"                                                 \
  -e "MESOS_ZK=zk://${BOX_IP}:2181/mesos"                                 \
  -e "MESOS_PORT=5050"                                                    \
  -e "MESOS_LOG_DIR=/var/log/mesos"                                       \
  -e "MESOS_QUORUM=1"                                                     \
  -e "MESOS_REGISTRY=in_memory"                                           \
  -e "MESOS_WORK_DIR=/var/lib/mesos"                                      \
  -e "MESOS_ROLES='*',slave_public"                                       \
  mesosphere/mesos-master:0.28.0-2.0.16.ubuntu1404
elif [[ ${RUNNING} == "false" ]]; then
docker start ${PREFIX}-master
fi

#
# - run the mesos slave
# - you can add more slaves by piling up similar containers
# - clamp to version 0.28.0-2.0.16.ubuntu1404
#
print_title "setting up Mesos slave..."
RUNNING=$(docker inspect --format="{{ .State.Running }}" ${PREFIX}-slave)
if [[ $? -eq 1 ]]; then
docker run -d                                                             \
  --net="host"                                                            \
  --name ${PREFIX}-slave                                                  \
  -p 5051:5051                                                            \
  -p 30001-30021:1-21                                                     \
  -p 30023-35050:23-5050                                                  \
  -p 35052-62000:5052-32000                                               \
  -e "MESOS_HOSTNAME=${BOX_IP}"                                           \
  -e "MESOS_MASTER=zk://${BOX_IP}:2181/mesos"                             \
  -e "MESOS_IP=${BOX_IP}"                                                 \
  -e "MESOS_LOG_DIR=/var/log/mesos"                                       \
  -e "MESOS_LOGGING_LEVEL=INFO"                                           \
  -e "MESOS_PORT=5051"                                                    \
  -e "MESOS_DEFAULT_ROLE=slave_public"                                    \
  -e "MESOS_RESOURCES=cpus:128;mem:204800;ports:[1-21,23-5050,5052-32000]"\
  -e "MESOS_CONTAINERIZERS=docker"                                        \
  -e "MESOS_EXECUTOR_REGISTRATION_TIMEOUT=5mins"                          \
  -e "MESOS_DOCKER_SOCK=/var/run/docker.sock"                             \
  -e "MESOS_CGROUPS_HIERARCHY=/sys/fs/cgroup"                             \
  -v /etc:/etc                                                            \
  -v /sys:/sys                                                            \
  -v /cgroup:/cgroup                                                      \
  -v /var/run/docker.sock:/var/run/docker.sock                            \
  -v /usr/local/bin/docker:/bin/docker                                    \
  mesosphere/mesos-slave:0.28.0-2.0.16.ubuntu1404
elif [[ ${RUNNING} == "false" ]]; then
docker start ${PREFIX}-slave
fi

#
# - run a single marathon framework master
# - clamp to version 1.1.1
#
print_title "setting up Marathon..."
RUNNING=$(docker inspect --format="{{ .State.Running }}" ${PREFIX}-marathon)
if [[ $? -eq 1 ]]; then
  docker run -d                                                             \
    --name ${PREFIX}-marathon                                               \
    -p 8080:8080                                                            \
    -e "MARATHON_MESOS_ROLE=slave_public"                                   \
    mesosphere/marathon:v1.1.1                                              \
    --master zk://${BOX_IP}:2181/mesos                                      \
    --zk zk://${BOX_IP}:2181/marathon
elif [[ ${RUNNING} == "false" ]]; then
  docker start ${PREFIX}-marathon
fi

#
# - upload both to /etc
# - start mesos-dns
# - docker-machine scp doesn't work properly on windows
# - clamp to version 0.5.2
#
print_title "setting up Mesos-DNS..."
cat "$TMP/mesos-dns.json" | docker-machine ssh $BOX "cat > /etc/mesos-dns.json"
cat "$TMP/resolv.conf"    | docker-machine ssh $BOX "cat > /etc/resolv.conf"
RUNNING=$(docker inspect --format="{{ .State.Running }}" ${PREFIX}-mesos-dns)
if [[ $? -eq 1 ]]; then
  docker run -d                                                             \
    --net="host"                                                            \
    --name ${PREFIX}-mesos-dns                                              \
    -v "/etc/mesos-dns.json:/etc/mesos-dns.json"                            \
    -v "/tmp:/tmp"                                                          \
    mesosphere/mesos-dns:0.5.2 /usr/bin/mesos-dns -config=/etc/mesos-dns.json
elif [[ ${RUNNING} == "false" ]]; then
  docker start ${PREFIX}-mesos-dns
fi

#
# - run marathon-lb (which will bind to TCP 80)
# - clamp to version 1.3.1 (1.3.2 has breaking changes)
#
print_title "setting up Marathon-lb..."
RUNNING=$(docker inspect --format="{{ .State.Running }}" ${PREFIX}-marathon-lb)
if [[ $? -eq 1 ]]; then
  docker run -d                                                             \
    --net="host"                                                            \
    --name ${PREFIX}-marathon-lb                                            \
    --privileged                                                            \
    -e PORTS="9090,9091,4080,4443"                                          \
    mesosphere/marathon-lb:v1.3.1 sse --group '*' -m http://${BOX_IP}:8080
  elif [[ ${RUNNING} == "false" ]]; then
  docker start ${PREFIX}-marathon-lb
fi

#
# - attempt to connect to the UI endpoint
# - try up to a set amount and sleep with up to 5 seconds between
# - abort if marathon somehow is still not up at the end
#
N=0
ATTEMPTS=60
echo "waiting for marathon to start..."
printf "."
until [[ $(curl -I http://${BOX_IP}:8080/ping 2>/dev/null | head -n 1 | awk -F " " '{print $2}') == "200" ]] || [[ $N -eq $ATTEMPTS ]]; do
  let T=1+2**N/4
  if [[ $T -gt 5 ]] ; then
    sleep 5
  else
    sleep $T
  fi
  let N=N+1
  printf "."
done
echo
if [[ $N -eq $ATTEMPTS ]] ; then
  print_error "unable to start marathon (are you experiencing issues ?), aborting"
  exit 1
fi
