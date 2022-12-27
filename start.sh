#!/bin/bash

# запуск NAMENODE в сети HADOOP_NETWORK, также назначение открытых портов для одключения извне сети
docker run -d --net hadoop_network --hostname namenode-master -p 9870:9870 -p 50030:50030 -p 8020:8020 --name namenode namenode:1

# запуск DATANODE 1 в сети HADOOP_NETWORK
docker run -d --net hadoop_network --name datanode-1 datanode:1

# запуск DATANODE 2 в сети HADOOP_NETWORK
docker run -d --net hadoop_network --name datanode-2 datanode:1

# запуск DATANODE 3 в сети HADOOP_NETWORK
docker run -d --net hadoop_network --name datanode-3 datanode:1

sudo docker exec -it namenode bash