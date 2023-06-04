#!/bin/bash

<<<<<<< HEAD
generate_random_string() {
    length=5
    characters="abcdefghijklmnopqrstuvwxyz"
    random_string=$(LC_CTYPE=C tr -dc 'a-z' < /dev/urandom | fold -w $length | head -n 1)
    echo "$random_string"
}

if [ $# -ne 2 ]; then
    echo "Usage: sh create_bucket.sh <bucket_name> <region>"
    exit 1
fi

bucket_name="$1"
region="$2"
random_string=$(generate_random_string)

aws s3api create-bucket --bucket "${bucket_name}-${random_string}" --region "${region}" --create-bucket-configuration LocationConstraint="${region}"
=======
# Set environmental variables
source env.sh

# Create S3 bucket
aws s3api create-bucket --bucket $TF_VAR_app_name-$TF_VAR_env_name --region $AWS_DEFAULT_REGION --create-bucket-configuration LocationConstraint=$AWS_DEFAULT_REGION
>>>>>>> 40d89e2f26e53ec3c65dce27da44d3b8f9f13bdf
