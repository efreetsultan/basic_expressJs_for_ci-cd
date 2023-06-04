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
<<<<<<< HEAD
            steps {
                sh "docker load -i app/hello-jenkins.tar"
                sh "kubectl apply -f k8s/backend.yaml"
            }

        stage('Delete S3 Bucket Contents') {
            steps {
                script {
                S3_BUCKET_NAME = sh(script: 'terraform output s3_for_hosting', returnStdout: true).trim()
                withAWS(region: env.AWS_REGION) {
                    sh "aws s3 rm s3://${S3_BUCKET_NAME} --recursive"
                }
                }
            }
        }
        
        stage('Build React App') {
            steps {
                dir('client') {
                sh 'npm install'
                sh 'npm run build'
                }
            }
        }
        
        stage('Upload Build Folder to S3') {
            steps {
                script {
                S3_BUCKET_NAME = sh(script: 'terraform output s3_for_hosting', returnStdout: true).trim()
                withAWS(region: env.AWS_REGION) {
                    sh "aws s3 sync build/ s3://${S3_BUCKET_NAME}"
                }
                }
            }
        }
=======
    steps {
        sh "docker load -i app/hello-jenkins.tar"
        sh "kubectl apply -f k8s/app.yaml"
    }
>>>>>>> 40d89e2f26e53ec3c65dce27da44d3b8f9f13bdf
}
    }
    post {
        success {
            sh "kubectl get svc -o wide"
        }
    }
}
