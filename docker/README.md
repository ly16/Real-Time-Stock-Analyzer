# Docker env
- eval $(docker-machine env bigdata)

- local-setup.sh for starting Kakfa, Cassandra, Zookeeper containers

## For MacOS

1. Get the env for docker-machine, 2CPU, 2G
```sh
docker-machine create --driver virtualbox --virtualbox-cpu-count 2 --virtualbox-memory 2048 bigdata
```
```
Docker-machine ip bigdata

eval $(docker-machine env bigdata)
```

2. Run all of the docker containers (Kafka, Cassandra, Zookeeper,redis)

```sh
./local-setup.sh bigdata
```

