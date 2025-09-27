pipeline {
    agent any
    
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
                sh 'terraform plan -out=tfplan'
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
            echo 'Deployment failed! Check Terraform logs.'
        }
    }
}
