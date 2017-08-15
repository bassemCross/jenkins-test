#!/bin/bash
if [ ! -f "./keyPair.pem" ]
  then
    aws ec2 create-key-pair --key-name $KEY_PAIR_NAME --query 'KeyMaterial' --output text >./keyPair.pem
    chmod 600 ./keyPair.pem
fi

if [ ! -f "./ec2.inst" ]
  then
    aws ec2 run-instances \
--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
--image-id $AMI_ID \
--count $EC2_COUNT \
--instance-type $INSTANCE_TYPE \
--key-name $KEY_PAIR_NAME \
--security-group-ids $SECURITY_GROUP_IDS \
--subnet-id $SUBNET_ID \
--query "Instances[0].InstanceId" --output text > ./ec2.inst
fi
INSTANCE_ID=`cat ./ec2.inst`
aws ec2 wait instance-status-ok --instance-ids $INSTANCE_ID
