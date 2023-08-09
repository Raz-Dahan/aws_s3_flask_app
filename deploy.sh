#!/bin/bash

INSTANCE_IP=$(aws ec2 describe-instances --region eu-central-1 --filters Name=tag:tier,Values=app --query 'Reservations[].Instances[].PublicIpAddress' --output text)
RSA_Key="~/.ssh/raz-key.pem"

scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $RSA_Key ~/Documents/.env ubuntu@$INSTANCE_IP:/home/ubuntu
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $RSA_Key ubuntu@$INSTANCE_IP "
sudo apt update -y
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing Git..."
    sudo apt install git -y
else
    echo "Git is already installed."
fi
if ! command -v docker &> /dev/null; then
    echo 'Docker is not installed. Installing Docker...'
    sudo apt install docker.io -y
    sudo systemctl start docker
    sudo systemctl enable docker
else
    echo 'Docker is already installed.'
fi
if ! command -v docker-compose &> /dev/null; then
    echo 'Docker Compose is not installed. Installing Docker Compose...'
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo 'Docker Compose has been installed.'
else
    echo 'Docker Compose is already installed.'
fi
if [ ! -d flask_image_downloader ]; then
    echo "Cloning repository..."
    git clone https://github.com/Raz-Dahan/flask_image_downloader.git
    cd flask_image_downloader
    cp /home/ubuntu/.env .env
    sudo docker-compose build
else
    echo "Repository directory already exists. Pulling latest changes..."
    cd flask_image_downloader
    if git pull --ff-only; then
        echo "Changes pulled successfully."
        cp /home/ubuntu/.env .env
        sudo docker-compose build
    else
        echo "No changes in the repository."
    fi
fi
if sudo docker ps | grep -q image_downloader_app; then
    sudo docker-compose -f docker-compose.yml -f production.yml down
    sudo docker-compose -f docker-compose.yml -f production.yml up -d --scale app=3
else
    sudo docker-compose -f docker-compose.yml -f production.yml up -d --scale app=3
fi
"