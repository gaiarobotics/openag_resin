OpenAg multi container deployment tool
==========

A Raspberry Pi 3 docker application container for resin.io. Useful to provide docker configuration, git push deploys, a partial build server, and remote access to your project.

The application starts a docker-in-docker instance using [hypriot](hypriot.com), which builds and runs the containers via docker-compose.


Instructions
--------------

- Create a Raspberry Pi 3 application in [resin.io](https://resin.io)

- Download and flash the device OS onto the SD card

- Connect your SD card on the Raspberry Pi, also the Arduino Mega to one of the USB ports

- Clone this repo

  `git clone https://github.com/davoclavo/openag-resin-multi-container.git`

- Set up a remote to point to your new resin application repo

  `git remote add resin your-user@git.resin.io:your-user/your-application-name.git``

- Push to the `master` branch of that remote. You should see the docker on the build servers, then it is uploaded to a docker registry

  `git push resin master`

- Go to your device summary page on resin.io. Some of your log sections should look like these:

> Downloading, installing and starting application. This application was built and uploaded to the docker registry during the `git push` 

```
11.09.16 22:50:43 [-0700] Downloading application 'registry.resin.io/openag-rpi/1c8b1c527bdd5796bd6273t23d6e7f'
11.09.16 22:51:04 [-0700] Downloaded application 'registry.resin.io/openag-rpi/1c8b1c527bdd5796bd6273t23d6e7f'
11.09.16 22:51:15 [-0700] Installing application 'registry.resin.io/openag-rpi/1c8b1c527bdd5796bd6273t23d6e7f'
11.09.16 22:52:07 [-0700] Installed application 'registry.resin.io/openag-rpi/1c8b1c527bdd5796bd6273t23d6e7f'
11.09.16 22:52:07 [-0700] Starting application 'registry.resin.io/openag-rpi/1c8b1c527bdd5796bd6273t23d6e7f'
11.09.16 22:52:11 [-0700] Started application 'registry.resin.io/openag-rpi/1c8b1c527bdd5796bd6273t23d6e7f'
```

> Application initialization

```
11.09.16 22:52:11 [-0700] Systemd init system enabled.
11.09.16 22:52:11 [-0700] [/lib/systemd/system/docker.service:19] Unknown lvalue 'Delegate' in section 'Service'
11.09.16 22:52:14 [-0700] + sed -i 's|docker daemon|docker daemon -g /data|' /lib/systemd/system/docker.service
11.09.16 22:52:14 [-0700] + systemctl daemon-reload
11.09.16 22:52:15 [-0700] + systemctl restart docker
```

> Start the docker-compose service in detach mode. The first time this runs it will take a while, as the images have to be downloaded.

```
11.09.16 22:52:32 [-0700] + docker-compose up -d --remove-orphans
```

> If it were the first time deploying, you'll see a mess of download logs of docker images onto the Raspberry Pi. Go grab a cup of coffee it can take a while
> If the images were already cached, this is what you'd see:

```
11.09.16 22:52:35 [-0700] apps_db_1 is up-to-date
11.09.16 22:52:35 [-0700] apps_brain_1 is up-to-date
```

> At the end there should be some cleanup to save space on the SD card

```
11.09.16 22:52:35 [-0700] ++ docker ps -a -q -f status=exited
11.09.16 22:52:36 [-0700] + docker rm -v
11.09.16 22:52:36 [-0700] + :
11.09.16 22:52:36 [-0700] ++ docker images -f dangling=true -q
11.09.16 22:52:36 [-0700] + docker rmi
11.09.16 22:52:36 [-0700] + :
```

 - Now you should be able to locally ssh to your device using `root` as username and password. Make sure to replace the ip with your device one, it can be located on your resin device dashboard

`ssh root@192.168.0.99`

- Or you can ssh remotely using the [resin-cli](https://github.com/resin-io/resin-cli). Make sure to grab your device UUID from the resin dashboard

`resin ssh u7xh8j`


Debug
------

- ssh `root@localip` and `export $(xargs -n 1 -0 < /proc/1/environ)` if you want the host env variables
- Look at your docker configuration `docker info`
- Check if containers are running `docker ps`
- Try to start docker-compose `cd /apps && docker-compose up -d`


Useful Links
------

- [OpenAg brain](https://github.com/OpenAgInitiative/openag_brain)
- [OpenAg brain docker stuff](https://github.com/OpenAgInitiative/openag_brain_docker_rpi)
- [Resin.io Blog entry about multi container apps](https://resin.io/blog/multi-container-with-docker-compose-on-resin-io/)
- [Resin multi container generic repo](https://github.com/justin8/resin-multi-container)
- [Problems with USB devices not showing up in /dev](https://talk.resin.io/t/problems-connecting-to-usb-serialport-from-container/24)
