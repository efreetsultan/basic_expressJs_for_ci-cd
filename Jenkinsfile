pipeline {
    agent any
    triggers {
        branch 'main'
    }
    environment {
        AWS_REGION = "eu-west-2"
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/efreetsultan/basic_expressJs_for_ci-cd.git'
            }
        }
        stage('Terraform') {
            steps {
                sh 'terraform init'
                sh 'terraform plan'
                sh 'terraform apply -auto-approve'

                script {
          ECR_REPOSITORY_NAME = sh(script: 'terraform output ecr_repository_name', returnStdout: true).trim()
          ECR_REGISTRY_URL = sh(script: 'terraform output ecr_registry_url', returnStdout: true).trim()
          EKS_CLUSTER_NAME = sh(script: 'terraform output eks_cluster_name', returnStdout: true).trim()
          
          env.ECR_REGISTRY = "${ECR_REGISTRY_URL}/${ECR_REPOSITORY_NAME}"
          env.IMAGE_NAME = "${ECR_REGISTRY_URL}/${ECR_REPOSITORY_NAME}:latest"
          env.EKS_CLUSTER = "${EKS_CLUSTER_NAME}"
        }
            }
        }
        stage('Build Docker Image') {
            steps {
                dir('backend') {
                    sh 'docker build -t hello-jenkins .'
                    sh 'docker tag hello-jenkins $IMAGE_NAME'
                }
            }
        }
        stage('Run Tests') {
            steps {
                dir('test') {
                    sh 'docker run --rm -v $(pwd):/app -w /app node:14 npm install'
                    sh 'docker run --rm -v $(pwd):/app -w /app node:14 npm test'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                dir('app') {
                    sh "docker push $IMAGE_NAME"
                    sh "docker save hello-jenkins -o hello-jenkins.tar"
                }
            }
        }
        stage('Deploy to EKS') {
    when {
        allOf {
            expression { currentBuild.result == 'SUCCESS' }
            expression { sh(script: 'npm run test-coverage | grep "Coverage: 100%"', returnStatus: true) == 0 }
        }
    }
    steps {
        sh "docker load -i app/hello-jenkins.tar"
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
