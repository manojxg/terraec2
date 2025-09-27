pipeline {
    agent any
    
    
    environment {
       
        AWS_PROFILE = "/root/.aws/credentials" 
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
               
                sh "terraform plan -out=tfplan"
            }
        }
        
        stage('Terraform Apply') {
            steps {
               
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
    
    post {
        # The 'always' block ensures the output runs even if apply partially fails.
        always {
            sh 'terraform output public_ip || true' 
        }
        failure {
            echo 'Deployment failed! Check Terraform logs for the specific missing argument.'
        }
        success {
            echo 'EC2 instance successfully created with existing network resources.'
        }
    }
}
