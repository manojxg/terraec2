pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = "us-east-1"
        // Jenkins should have AWS credentials configured in "Manage Jenkins > Credentials"
        AWS_CREDENTIALS = credentials('aws-creds-id') 
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo/terraform-ec2.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                terraform init
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                export AWS_ACCESS_KEY_ID=$AWS_CREDENTIALS_USR
                export AWS_SECRET_ACCESS_KEY=$AWS_CREDENTIALS_PSW
                terraform plan -out=tfplan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                input(message: 'Do you want to apply changes?')
                sh '''
                export AWS_ACCESS_KEY_ID=$AWS_CREDENTIALS_USR
                export AWS_SECRET_ACCESS_KEY=$AWS_CREDENTIALS_PSW
                terraform apply -auto-approve tfplan
                '''
            }
        }
    }
}
