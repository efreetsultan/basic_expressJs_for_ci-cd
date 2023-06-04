#!/bin/bash

ssh-keygen -t rsa -b 4096 -m pem -f bastion && openssl rsa -in bastion -outform pem && chmod 400 bastion