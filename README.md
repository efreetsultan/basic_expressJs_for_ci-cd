# Basic_ExpressJS_For_Ci-Cd

This is basic application, with ExpressJs backend and React frontend. AWS infrastructure created with Terraform. Deployed with Kubernetes and S3 web hosting

## Used technologies:<br>


|  |  |
| --- | --- |
| Javascript/NodeJs | [![My Skills](https://skillicons.dev/icons?i=nodejs)](https://skillicons.dev) |
| Amazon Web Service | [![My Skills](https://skillicons.dev/icons?i=aws)](https://skillicons.dev) |
| Docker | [![My Skills](https://skillicons.dev/icons?i=docker)](https://skillicons.dev) |
| Git | [![My Skills](https://skillicons.dev/icons?i=git)](https://skillicons.dev) |
| Bash scripting | [![My Skills](https://skillicons.dev/icons?i=bash)](https://skillicons.dev) |
| GitHub Actions | [![My Skills](https://skillicons.dev/icons?i=githubactions)](https://skillicons.dev) |
| Kubernetes | [![My Skills](https://skillicons.dev/icons?i=kubernetes)](https://skillicons.dev) |
| Terraform |  |

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

3. Save your AWS credentials as secrets in GitHub:

   - Go to your repository on GitHub.
   - Navigate to **Settings** > **Secrets**.
   - Click on **New repository secret**.
   - Add your AWS access key as the secret name and the corresponding secret value.
   - Repeat the process for your AWS secret access key.

4. Create the S3 bucket:

   ```
   sh s3backend.sh <bucketname> <region>
   ```

   This script creates an S3 bucket for the backend. Replace `<bucketname>` with the desired name for your bucket and `<region>` with the AWS region where you want to create the bucket.

5. Rewrite the placeholder names:

   - In `dynamodb.tf`, replace the placeholder `<name>` with the desired name for your DynamoDB table.
   - In `s3backend.tf`, replace the placeholder `<bucket>` with the name of the S3 bucket you created in the previous step.

6. Set the necessary variables in `terraform.tfvars`:

   - Modify the values in `terraform.tfvars` according to your requirements.

7. Commit and push the changes to your repository.

Now you have set up the necessary configurations and scripts in your repository. GitHub Actions will automatically detect your project's configuration and run the CI/CD pipeline based on the available conventions and triggers.

During the CI/CD pipeline, the following actions will be performed:

- Installing dependencies
- Configuring AWS credentials
- Creating the S3 bucket
- Configuring Terraform
- Applying Terraform changes
- Building and pushing the Docker image
- Deploying the application
- Running unit tests

GitHub Actions will handle these steps based on the detected configurations and events such as commits to the `main` branch.

Ensure that you have the appropriate permissions and access control in place for the GitHub Actions workflow to interact with your AWS resources and perform the necessary operations.