#!/bin/bash

BASTION_IP=$(terraform output -raw bastion_host_ip)

PRIVATE_KEY_PATH="bastion.pub"

ssh -A -i "$PRIVATE_KEY_PATH" ec2-user@"$BASTION_IP"
