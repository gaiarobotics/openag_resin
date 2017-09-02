#!/bin/bash
# https://github.com/docker/compose/issues/1083#issuecomment-216540808

for container_id in $(docker ps -a --filter="name=$name" -q);

do file=$(docker inspect $container_id | grep -G '"LogPath": "*"' | sed -e 's/.*"LogPath": "//g' | sed -e 's/",//g');

   if [ -f $file ]
   then
       rm $file;
   fi

done
