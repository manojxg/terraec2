pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID = '' 
        
        EC2_SSH_PUB_KEY = '/var/lib/jenkins/.ssh/id_rsa.pub' 
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm 
            }
        }
        
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        
        stage('Terraform Plan') {
            steps {
                sh "terraform plan -var=\"public_key_path=${env.EC2_SSH_PUB_KEY}\" -out=tfplan"
            }
        }
        
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
    
    post {
        always {
            sh 'terraform output public_ip || true' 
        }
        failure {
            echo 'Deployment failed! Check the IAM role and EC2 IMDS permissions.'
        }
    }
}
