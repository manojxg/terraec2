pipeline {
    agent any
    
    stages {
        stage('Checkout Code') {
            steps {
                # Ensure the SCM (e.g., Git) is configured correctly to pull the Terraform code
                checkout scm 
            }
        }
        
        stage('Terraform Init') {
            steps {
                # Initialize Terraform and download the AWS provider
                sh 'terraform init'
            }
        }
        
        stage('Terraform Plan') {
            steps {
                # Validate syntax and create a deployment plan
                sh 'terraform plan -out=tfplan'
            }
        }
        
        stage('Terraform Apply') {
            steps {
                # Apply the plan. Authentication uses the IAM Role attached to the Jenkins EC2 instance.
                sh 'terraform apply -auto-approve tfplan'
            }
        }
        
        stage('Show Output') {
            steps {
                # Display the public IP of the new EC2 instance
                sh 'terraform output public_ip'
            }
        }
    }
    
    post {
        # Optional Cleanup: Uncomment to destroy the EC2 instance after the pipeline finishes
        /*
        always {
            sh 'terraform destroy -auto-approve'
        }
        */
    }
}
