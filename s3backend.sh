#!/bin/bash

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
