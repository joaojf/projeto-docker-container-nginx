#!/bin/bash
USER="sysadm"

useradd ${USER} -m -d "/home/$USER" -c "New System Administrator" -s /bin/bash
echo "Usuário Criado! `grep ${USER} /etc/passwd`"

sudo apt update -y
sudo apt install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl status docker

sudo usermod -aG docker ${USER}
su - ${USER}
groups
sudo usermod -aG docker ${USER}

docker run hello-world

VOLUMENAME="app_nginx"
docker volume create ${VOLUMENAME}
docker volume ls
docker volume inspect ${VOLUMENAME}
docker container run -d --name nginx -p 80:80 -m 512M --cpus 0.5 --mount type=volume,src=${VOLUMENAME},dst=/usr/share/nginx/html nginx
docker container ls
