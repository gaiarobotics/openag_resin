OpenAg multi container resin.io deployment tool
==========

The application starts a docker-in-docker instance and runs docker-compose, which builds and runs the containers.

Create a RPI3 application in resin.io and push the contents of this repo to your resin remote.

Make sure your Arduino is connected to one of the USB ports beforehand.

Depending on your internet connection might take a while to finish building, as the rpi is running docker-in-docker, resin is unable to build that in their servers, so be patient.


Debug
------

- ssh `root@localip` and `export $(xargs -n 1 -0 < /proc/1/environ)`
- Check if containers are running `docker ps`
- Try to start docker-compose `cd /apps && docker-compose up -d`


Useful Links
------

https://github.com/OpenAgInitiative/openag_brain_docker_rpi

https://github.com/OpenAgInitiative/openag_brain

https://resin.io/blog/multi-container-with-docker-compose-on-resin-io/

https://github.com/justin8/resin-multi-container

https://talk.resin.io/t/problems-connecting-to-usb-serialport-from-container/24

