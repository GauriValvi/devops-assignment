pipeline {
    agent any

    environment {
        AWS_REGION     = 'ap-south-1'
        AWS_ACCOUNT_ID = '039293892213'
        ECR_REGISTRY   = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        IMAGE_NAME     = 'python-app'
        EKS_CLUSTER    = 'devops-eks'
    }

    stages {

        stage('Check Tools') {
            steps {
                sh '''
                docker --version
                aws --version
                kubectl version --client
                terraform --version
                git --version
                '''
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/GauriValvi/devops-assignment.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t ${IMAGE_NAME}:latest ./app
                '''
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    sh '''
                    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}
                    docker tag ${IMAGE_NAME}:latest ${ECR_REGISTRY}/${IMAGE_NAME}:latest
                    docker push ${ECR_REGISTRY}/${IMAGE_NAME}:latest
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                echo 'Skipping Terraform because infrastructure already exists'
            }
        }

        stage('Deploy to EKS') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    sh '''
                    aws eks update-kubeconfig --region ${AWS_REGION} --name ${EKS_CLUSTER}
                    kubectl apply -f kubernetes/
                    kubectl get pods
                    kubectl get svc
                    '''
                }
            }
        }

    }   // <-- missing closing brace for stages

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
