Debug
------

Open ssh session

`resin ssh <device_uuid>`


Build and run containers in deatached mode

```
cd apps
docker-compose up -d
```

If that fails, manually build docker container

`docker build -t brain .`


Attempt to run it

`docker-compose run --service-ports brain`

to expose the container name as `brain` and let the db access it
`docker-compose run --service-ports --name brain brain bash`


Run interactive terminal in container using bash

`docker run -it --rm brain bash`
`docker exec -it brain /home/pi/catkin_ws/devel/env.sh /bin/bash`


### While inside the container:

Start openag_brain

`~/catkin_ws/devel/env.sh rosrun openag_brain main`

### Raspberry pi cam ###

https://docs.resin.io/hardware/i2c-and-spi/
RESIN_HOST_CONFIG_gpu_mem to 128
RESIN_HOST_CONFIG_start_x to 1 in the fleet or device configuration.

Make it available at `/dev/video0`

`sudo modprobe bcm2835-v4l2`


Errors
------

`Cannot start service brain: linux runtime spec devices: error gathering device information while adding custom device "/dev/ttyACM0": lstat /dev/ttyACM0: no such file or directory`


TODO
----

- Figure out how to mock the `docker-compose up -d` using raw docker commands. Specifically mapping the exposed ports and stuff

- Try connecting it in another USB port
- Try using another power supply
- Try mapping: /dev/ttyUSB0:/dev/ttyACM0
- Try `network_mode: host`
- Try to add this: https://www.raspberrypi.org/forums/viewtopic.php?f=32&t=6832

Try to add this as 55-odd.rules to /etc/udev/rules.d/

CODE: SELECT ALL
KERNEL=="ttyACM0", SYMLINK+="ttyS7"

This will add a new device link to your original ttyACM0, enabling Arduino IDE and hopefully your pyserial to see your connected device as ttyS7.

If you get 
ERROR: An HTTP request took too long to complete. Retry with --verbose to obtain debug information.
If you encounter this issue regularly because of slow network conditions, consider setting COMPOSE_HTTP_TIMEOUT to a higher value (current value: 60).
COMPOSE_HTTP_TIMEOUT=120 docker-compose up -d
or 
COMPOSE_HTTP_TIMEOUT=120 docker-compose stop




docker run --rm --privileged multiarch/qemu-user-static:register --reset

http://blog.hypriot.com/post/setup-simple-ci-pipeline-for-arm-images/

Credit:
https://github.com/PabloGN/Docker-raspbian-ros-indigo
https://github.com/multiarch/qemu-user-static


--------



















```
cd /apps
git submodule update --recursive --remote
# build from source
```
