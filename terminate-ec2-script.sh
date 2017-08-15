#!/bin/bash
if [ -f "./ec2.inst" ]
  then
    INSTANCE_ID=`cat ./ec2.inst`
    aws ec2 terminate-instances --instance-ids $INSTANCE_ID
    aws ec2 wait instance-terminated --instance-ids $INSTANCE_ID
    rm ./ec2.inst
fi
if [ -f "./keyPair.pem" ]
then
    aws ec2 delete-key-pair --key-name $KEY_PAIR_NAME
    rm ./keyPair.pem
fi
