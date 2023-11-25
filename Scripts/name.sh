#!/bin/bash


# Check wether aws cli is configured or not and terrafom is installed or not 


if [ -z "$(which aws)" ]; then
	echo "AWS CLI is not configured"
	exit 1
else
	echo "AWS CLI is configured"
fi

if [ -z "$(which terraform)" ]; then
	echo "Terraform is not installed"
	exit 1
else
	echo "Terraform is installed"
fi 

cd ../Terraform 

terrafom init && terraform apply -auto-approve 

aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,PublicIpAddress,State.Name]' --output text | grep running | awk '{print $2}' > name.txt 
