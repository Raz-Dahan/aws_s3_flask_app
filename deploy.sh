#!/bin/bash

INSTANCE_IP=$(aws ec2 describe-instances --region eu-central-1 --filters Name=tag:tier,Values=app --query 'Reservations[].Instances[].PublicIpAddress' --output text)
RSA_Key="~/.ssh/raz-key.pem"

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
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
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
else
    echo "Repository directory already exists. Pulling latest changes..."
    cd flask_image_downloader
    git pull
fi
docker build -t image_downloader_app:latest .
docker-compose up -d
"