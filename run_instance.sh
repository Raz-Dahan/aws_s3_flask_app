#!/bin/bash

AWS_REGION="eu-central-1"

echo '{
  "MaxCount": 1,
  "MinCount": 1,
  "ImageId": "ami-04e601abe3e1a910f",
  "InstanceType": "t2.micro",
  "KeyName": "raz-key",
  "EbsOptimized": false,
  "NetworkInterfaces": [
    {
      "AssociatePublicIpAddress": true,
      "DeviceIndex": 0,
      "Groups": [
        "sg-06fe143a3a8ada778"
      ]
    }
  ],
  "TagSpecifications": [
    {
      "ResourceType": "instance",
      "Tags": [
        {
          "Key": "Name",
          "Value": "ImageDownloader"
        },
        {
          "Key": "tier",
          "Value": "app"
        }
      ]
    }
  ],
  "PrivateDnsNameOptions": {
    "HostnameType": "ip-name",
    "EnableResourceNameDnsARecord": true,
    "EnableResourceNameDnsAAAARecord": false
  }
}' > instance-config.json

aws ec2 run-instances --cli-input-json file://instance-config.json &> /dev/null

echo 'New "ImageDownloader" instance is running'
