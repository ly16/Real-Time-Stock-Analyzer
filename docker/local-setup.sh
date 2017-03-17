#!/bin/bash

#
# - get the docker-machine name from commandline argument
# - in shell script, $0 is the program being invoked, and $1, $2.. are the actual arguments
#
MACHINE_NAME=$1

#
# - get the ip of target docker-machine
#
IP=$(docker-machine ip ${MACHINE_NAME})

#
# - run a single zookeeper broker
#
echo "start zookeeper"

#
# - get the running status of docker container named zookeeper
# - use > /dev/null to reduce the amount of logs
#
RUNNING=$(docker inspect --format="{{ .State.Running }}" zookeeper 2> /dev/null)

#
# - basic if else structure in shell script
#
if [[ $? -eq 1 ]]; then

    #
    # - cannot find docker container named zookeeper, create one
    # - for docker run command options, see: https://docs.docker.com/engine/reference/run/
    #
    docker run \
        -d \
        -p 2181:2181 \
        -p 2888:2888 \
        -p 3888:3888 \
        --name zookeeper \
        confluent/zookeeper
elif [[ ${RUNNING} == "false" ]]; then

    #
    # - otherwise, container exists but not running, start it
    #
    docker start zookeeper
fi

sleep 2

#
# - run the kafka broker
#
echo "start kafka"
RUNNING=$(docker inspect --format="{{ .State.Running }}" kafka 2> /dev/null)
if [[ $? -eq 1 ]]; then

    #
    # - cannot find docker container named kafka, create one
    # - for docker run command options, see: https://docs.docker.com/engine/reference/run/
    #
    # - here we explicitly configured Kafka advertised_host_name and advertised_port configuration
    #
    docker run \
        -d \
        -p 9092:9092 \
        -e KAFKA_ADVERTISED_HOST_NAME="${IP}" \
        -e KAFKA_ADVERTISED_PORT=9092 \
        --name kafka \
        --link zookeeper:zookeeper \
        confluent/kafka
elif [[ ${RUNNING} == "false" ]]; then

    #
    # - otherwise, container exists but not running, start it
    #
    docker start kafka
fi

#
# - run the cassandra
#
echo "start cassandra"
RUNNING=$(docker inspect --format="{{ .State.Running }}" cassandra 2> /dev/null)
if [[ $? -eq 1 ]]; then

    #
    # - cannot find docker container named cassandra, create one
    # - for docker run command options, see: https://docs.docker.com/engine/reference/run/
    #
    docker run \
        -d \
        -p 7199:7199 \
        -p 9042:9042 \
        -p 9160:9160 \
        -p 7001:7001 \
        --name cassandra \
        cassandra:3.7
elif [[ ${RUNNING} == "false" ]]; then

    #
    # - otherwise, container exists but not running, start it
    #
    docker start cassandra
fi

#
# - run the redis
#
echo "start redis"
RUNNING=$(docker inspect --format="{{ .State.Running }}" redis 2> /dev/null)
if [[ $? -eq 1 ]]; then

    #
    # - cannot find docker container named redis, create one
    # - for docker run command options, see: https://docs.docker.com/engine/reference/run/
    #
    docker run \
        -d \
        -p 6379:6379 \
        --name redis \
        redis:alpine
elif [[ ${RUNNING} == "false" ]]; then

    #
    # - otherwise, container exists but not running, start it
    #
    docker start redis
fi

#
# - run the elasticsearch
#
echo "start elasticsearch"
RUNNING=$(docker inspect --format="{{ .State.Running }}" elasticsearch 2> /dev/null)
if [[ $? -eq 1 ]]; then

    #
    # - cannot find docker container named redis, create one
    # - for docker run command options, see: https://docs.docker.com/engine/reference/run/
    #
    docker run \
        -d \
        -p 9200:9200 \
        --name elasticsearch \
        elasticsearch
elif [[ ${RUNNING} == "false" ]]; then

    #
    # - otherwise, container exists but not running, start it
    #
    docker start elasticsearch
fi

#
# - run the kibana
#
echo "start kibana"
RUNNING=$(docker inspect --format="{{ .State.Running }}" kibana 2> /dev/null)
if [[ $? -eq 1 ]]; then

    #
    # - cannot find docker container named redis, create one
    # - for docker run command options, see: https://docs.docker.com/engine/reference/run/
    #
    docker run \
        -d \
        -p 5601:5601 \
        --name kibana \
        -e ELASTICSEARCH_URL="http://${IP}:9200" \
        kibana
elif [[ ${RUNNING} == "false" ]]; then

    #
    # - otherwise, container exists but not running, start it
    #
    docker start kibana
fi