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
                sh "docker build -t hello-jenkins ."
                sh "docker tag hello-jenkins $IMAGE_NAME"
                sh "docker push $IMAGE_NAME"
                sh "docker save hello-jenkins -o hello-jenkins.tar"
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
                 sh "docker load -i hello-jenkins.tar"
                sh "kubectl apply -f k8s/app.yaml"
            }
        }
    }
    post {
        success {
            sh "kubectl get svc -o wide"
        }
    }
}
