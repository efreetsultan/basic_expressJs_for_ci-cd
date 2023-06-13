#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: sh create_bucket.sh <bucket_name> <region>"
  exit 1
fi

bucket_name="$1"
region="$2"
random_string=$(openssl rand -hex 3 | tr -d '[:digit:]' | tr '[:upper:]' '[:lower:]')

full_bucket_name="${bucket_name}-${random_string}"
aws s3api create-bucket --bucket "${full_bucket_name}" --region "${region}" --create-bucket-configuration LocationConstraint="${region}"
