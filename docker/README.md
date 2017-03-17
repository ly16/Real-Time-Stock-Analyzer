# Docker env


## 代码结构

1. local-setup.sh 快速部署单节点Kakfa, Cassandra, Zookeeper开发环境

## MacOS, *nix系统

1. Get the env for docker-machine, 2CPU, 2G
```sh
docker-machine create --driver virtualbox --virtualbox-cpu-count 2 --virtualbox-memory 2048 bigdata
```

Docker-machine ip bigdata

eval $(docker-machine env bigdata)


2. Run all of the docker containers (Kafka, Cassandra, Zookeeper,redis)

```sh
./local-setup.sh bigdata
```

