# My ExpressJS App

This is a basic ExpressJS application that has one endpoint that returns a string.

## Getting Started

### Prerequisites

Before you begin, make sure you have the following:

- Node.js
- npm
- Terraform
- AWS CLI

### Installing

1. Clone the repository:

   ```
   git clone https://github.com/efreetsultan/basic_expressJs_for_ci-cd
   cd basic_expressJs_for_ci-cd
   ```

2. Install the dependencies:

   ```
   npm install
   ```

3. Create the S3 bucket:

   ```
   source env.sh
   sh s3backend.sh
   ```

   This creates an S3 bucket that is used to store the Terraform state.

4. Create the DynamoDB table:

   ```
   terraform init -backend-config="bucket=<app-name>-<env-name>" -backend-config="dynamodb_table=<app-name>-<env-name>"
   terraform apply -var app_name=<app-name> -var env_name=<env-name>
   ```

   This creates a DynamoDB table that is used to lock the Terraform state. This also creates an ECR repository, an EKS cluster, an IAM role for the worker nodes, and other resources needed to deploy the application.

5. Build and push the Docker image:

   ```
   docker build -t <aws-account-id>.dkr.ecr.<region>.amazonaws.com/<app-name>:<tag> .
   aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <aws-account-id>.dkr.ecr.<region>.amazonaws.com
   docker push <aws-account-id>.dkr.ecr.<region>.amazonaws.com/<app-name>:<tag>
   ```

   This builds a Docker image for the application, logs in to the ECR repository, and pushes the image to the repository.

6. Deploy the application:

   ```
   kubectl apply -f k8s/
   ```

   This deploys the application to the EKS cluster using the Kubernetes manifests in the `k8s/` directory.

7. Test the application:

   ```
   npm test
   ```

   This runs the unit tests for the application.

## CI/CD Pipeline

This project also includes a Jenkinsfile that sets up a CI/CD pipeline for the application. The pipeline is triggered on commits to the `main` branch, and it performs the following steps:

1. Checkout the code from the repository.
2. Create the S3 bucket using the `creates3.sh` script.
3. Create the DynamoDB table and AWS resources using Terraform.
4. Build and push the Docker image.
5. Deploy the application to the EKS cluster.
6. Run the unit tests.
7. If the tests pass, deploy the application to the production environment.

To set up the pipeline, create a Jenkins job that uses the `Jenkinsfile` as its pipeline script. Make sure to set the necessary environmental variables for your AWS account and other configuration values.