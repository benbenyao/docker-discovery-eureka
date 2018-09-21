#!/bin/bash
echo '================开始向docker仓库推送镜像================'
CONTAINER_NAME=${1}
POM_VERSION=${2}
DOCKER_REGISTRY_URL=${3}
if [ ! -n "$CONTAINER_NAME" ]; then  
   CONTAINER_NAME=docker-discovery-eureka
fi
if [ ! -n "$POM_VERSION" ]; then  
   POM_VERSION=lastest
fi
if [ ! -n "$DOCKER_REGISTRY_URL" ]; then  
   DOCKER_REGISTRY_URL=192.168.2.105:6000
fi

image_tag=$DOCKER_REGISTRY_URL/cloud/$CONTAINER_NAME:${POM_VERSION}
docker tag $CONTAINER_NAME:${POM_VERSION} $image_tag
docker push $image_tag
#删掉docker构造镜像机器的image
docker rmi $image_tag
docker rmi $CONTAINER_NAME:${POM_VERSION}

#imageid=$(docker images |awk '{if($2=="<none>")  print $3}')
#if [ $imageid != "" ]; then #这里要处理的是数组
#   docker rmi $imageid
#fi
curl http://$DOCKER_REGISTRY_URL/v2/_catalog
echo '================结束向docker仓库推送镜像================'
