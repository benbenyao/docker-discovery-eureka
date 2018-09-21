#!/bin/bash
echo '================remote obatin image start================'
CONTAINER_NAME=$1
POM_VERSION=$2
DOCKER_REGISTRY_URL=$3
PORT=$4

if [ -z "$CONTAINER_NAME" ]; then  
   CONTAINER_NAME=docker-discovery-eureka
fi
if [ -z "$POM_VERSION" ]; then  
   POM_VERSION=lastest
fi
if [ -z "$DOCKER_REGISTRY_URL" ]; then  
   DOCKER_REGISTRY_URL=192.168.146.200:5000
fi
if [ -z "$PORT" ]; then  
   PORT=8761
fi

#echo $CONTAINER_NAME
#echo $POM_VERSION
#echo $DOCKER_REGISTRY_URL
#echo $PORT

docker pull $DOCKER_REGISTRY_URL/cloud/$CONTAINER_NAME:$POM_VERSION

echo '================remote obatin image end================'


echo '================remote启动容器start================'


#删除同名docker容器
cid=$(docker ps -a | grep "$CONTAINER_NAME" | awk '{print $1}')
if [ "$cid" != "" ]; then
   docker rm -f $cid
   sleep 3s
fi
docker run -d -p $PORT:8761 --name $CONTAINER_NAME $DOCKER_REGISTRY_URL/cloud/$CONTAINER_NAME:$POM_VERSION
#docker exec $CONTAINER_NAME /bin/sh -c "echo 172.18.100.196  eureka1 >> /etc/hosts"
#docker exec $CONTAINER_NAME /bin/sh -c "echo 172.18.100.196  eureka2 >> /etc/hosts"
#docker exec $CONTAINER_NAME /bin/sh -c "echo 172.18.100.196  bootmonitor >> /etc/hosts"


echo '================remote启动容器end================'
#docker logs -f $CONTAINER_NAME
