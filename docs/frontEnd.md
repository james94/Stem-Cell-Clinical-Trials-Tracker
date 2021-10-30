# FrontEnd: Install ReactJS on Ubuntu VM, Then Deploy ReactJS Docker Alpine Container

If you haven't installed Docker, refer to our
[Ubuntu Docker Install Guide](./dockerInstallUbuntu.md)

1\. Install npm (also installs node.js) on Ubuntu VM host if its not installed:

~~~bash
sudo apt-get install -y curl
# Mu installed Node 12.13.0, Npm 7.18.1.
curl -fsSL https://deb.nodesource.com/setup_12.x | bash
apt-get install -y nodejs

sudo apt -y install npm
~~~

<!-- **Optional**: Install create-react-app in case you need to create a new react app:

~~~bash
sudo npm -g install create-react-app@4.0.3
~~~

**Optional**: Create React SC_Clinical_Trials_Tracker:

~~~bash
create-react-app scct_tracker
~~~ -->

2\. Let's change to **mytrial-fe** directory:

~~~bash
cd $pwd/Stem-Cell-Clinical-Trials-Tracker/mytrial-fe
~~~

3\. Build and tag the Docker image for our ReactJS **mytrial-fe** app:

~~~bash
# Installs Node.js 13.12, npm 6.14.4
sudo docker build -t mytrial-fe:dev .
~~~

4\. Launch a Docker container named **scct_tracker** for our ReactJS app with code based from **mytrial-fe** folder:

~~~bash
sudo docker run -it \
    --name scct_tracker_fe \
    -v ${PWD}:/mytrial-fe \
    -v /mytrial-fe/node_modules \
    -p 3001:3000 \
    -e CHOKIDAR_USEPOLLINNG=true \
    mytrial-fe:dev
~~~

<!-- Check node version and npm version inside docker container scct_tracker -->

- `docker run` creates and runs a new container instance from the linux alpine image we just created
- `-it` starts the docker container in interactive mode
- `-v ${PWD}:/mytrial-fe` mounts the ReactJS code from Ubuntu VM host into the container at "/mytrial-fe"
- `-v /mytrial-fe/node_modules` configured another volume to use the container version of "node_modules" folder
- `-p 3001:3000` exposes the port 3000 to other Docker containers on the same network and port 3001 to the host
- `-e CHOKIDAR_USEPOLLINNG=true` enables a polling mechanism via **chokidar** so that hot-reloading will work

5\. Open your Ubuntu VM's browser http://localhost:3001/ and you should see the app. You can make a change to the `App` component within your code editor and see the app hot-reload.

If you need to get into the Docker alpine's container, execute the following command: 

~~~bash
sudo docker exec -it scct_tracker /bin/ash
~~~

**Optional**\. If you want to open the ReactJS app in your Windows or Mac host machine's browser outside the Ubuntu VM, if you are running your Ubuntu VM on Virtualbox, click:

- **Settings** -> **Network** -> **Advanced** -> **Port Forwarding** -> 

Add a new Port Forwarding Rule with following properties:

~~~bash
Name = SCCTT_ReactJS
Protocol = TCP
Host Port = 30001
Guest Port = 3001
~~~

Click OK, then OK again for the port forwarding to be saved. Then from your host machine's browser, access link: http://localhost:3001/ 

## Reference

- [Dockerizing a React App](https://mherman.org/blog/dockerizing-a-react-app/)
- [How to Install ReactJS on Ubuntu](https://www.tecmint.com/install-reactjs-on-ubuntu/)
- [NodeSource Node.js Binary Distributions](https://github.com/nodesource/distributions)
- [Hot Reloading in React](https://medium.com/@dan_abramov/hot-reloading-in-react-1140438583bf)
