// Jenkinsfile

pipeline {
    agent any
    
    environment {
        // Fix for "failed to get shared config profile" error:
        // Set an empty Access Key ID. This forces the AWS SDK to skip
        // the credentials file lookup and fall back to the IMDS/IAM Role.
        AWS_ACCESS_KEY_ID = '' 
        
        # IMPORTANT: Set this to the exact, existing public key file path 
        # on the Jenkins agent running this job.
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
                # Pass the key path variable to Terraform
                sh "terraform plan -var=\"public_key_path=${env.EC2_SSH_PUB_KEY}\" -out=tfplan"
            }
        }
        
        stage('Terraform Apply') {
            steps {
                # Execution is authenticated by the IAM Role of the Jenkins EC2 instance.
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
