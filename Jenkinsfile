pipeline {
    agent any
    triggers {
        branch 'master'
    }
    environment {
        ECR_REGISTRY = "837009352646.dkr.ecr.eu-west-2.amazonaws.com/hello-jenkins"
        IMAGE_NAME = "837009352646.dkr.ecr.eu-west-2.amazonaws.com/hello-jenkins:latest"
        EKS_CLUSTER = "eks"
        AWS_REGION = "us-west-2"
        ECR_ROLE_ARN = "" // here goes the ecr policy arn
        EKS_ROLE_ARN = "arn:aws:iam::837009352646:role/eks_cluster_policy"
    }
    stages {
        stage("Assume ECR Role") {
            steps {
                withRole(role: "${ECR_ROLE_ARN}", durationSeconds: 3600) {
                    sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}"
                }
            }
        }
        stage("Build and Push Docker Image") {
            steps {
                git 'https://github.com/efreetsultan/basic_expressJs_for_ci-cd'
                sh "cd node-express-app && docker build -t ${ECR_REGISTRY}/${IMAGE_NAME} . && docker push ${ECR_REGISTRY}/${IMAGE_NAME}"
            }
        }
        stage("Assume EKS Role") {
            steps {
                withRole(role: "${EKS_ROLE_ARN}", durationSeconds: 3600) {
                    sh "aws eks update-kubeconfig --name ${EKS_CLUSTER}"
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                sh "kubectl apply -f k8s/app.yaml"
            }
        }
    }
}
