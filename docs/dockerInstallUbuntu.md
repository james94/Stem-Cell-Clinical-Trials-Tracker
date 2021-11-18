# Install Docker on Ubuntu

<!-- SJSU CMPE 138 Fall 2021 TEAM1 -->

1\. Set up Docker Repository

~~~bash
sudo apt -y update
sudo apt -y install apt-transport-https ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt -y update
~~~

2\. Install Docker Engine

~~~bash
sudo apt -y install docker-ce docker-ce-cli containerd.io
~~~
