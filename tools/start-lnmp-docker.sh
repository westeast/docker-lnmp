#!/bin/bash
cd $HOME/data/docker-lnmp/mysql/data/ && git clean -df . && git checkout . 
cd $HOME/data/docker-lnmp/mysql/var/ && rm -f *.pid  && rm -f *.err && git checkout ib_logfile0 && git checkout mysql/pma*
docker stop lnmp;
docker rm lnmp;
docker run -d -i -t \
-p 8001:80 -p 443:443 -p 8002:3306 \
--privileged=true \
-v /Users/likenan/git:/code \
-v /tmp/lnmplogs:/home/wwwlogs \
-v $HOME/data/docker-lnmp/mysql/data:/usr/local/mysql/data \
-v $HOME/data/docker-lnmp/mysql/var:/usr/local/mysql/var \
-v $HOME/data/docker-lnmp/nginx_conf:/usr/local/nginx/conf \
-w /code \
--name=lnmp  westeast/lnmp-ubuntu:latest /root/start_lnmp.sh && open http://127.0.0.1:8001

