#!/usr/bin/env bash
image_version=`date +%Y%m%d%H%M`;
# 关闭vue-demo容器
docker stop vue-demo || true;
# 删除vue-demo容器
docker rm vue-demo || true;
# 删除vue/demo镜像
docker rmi --force $(docker images | grep vue/demo | awk '{print $3}')
# 构建vue/demo:$image_version镜像
docker build . -t vue/demo:$image_version;
# 查看镜像列表
docker images;
# 基于vue/demo 镜像 构建一个容器 vue-demo
docker run -p 9527:80 -d --name vue-demo vue/demo:$image_version;
# 查看日志
docker logs vue-demo;
#删除build过程中产生的镜像    #docker image prune -a -f
docker rmi $(docker images -f "dangling=true" -q)
# 对空间进行自动清理
#docker system prune -a -f



