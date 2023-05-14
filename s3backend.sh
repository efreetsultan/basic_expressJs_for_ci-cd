#!/bin/bash

# Set environmental variables
source env.sh

# Create S3 bucket
aws s3api create-bucket --bucket $TF_VAR_app_name-$TF_VAR_env_name --region $AWS_DEFAULT_REGION --create-bucket-configuration LocationConstraint=$AWS_DEFAULT_REGION
