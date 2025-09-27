pipeline {
    agent any

    environment {
        AWS_PROFILE = "myprofile"   // 👈 use profile name
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-org/terraform-ec2-jenkins.git'
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
                export AWS_PROFILE=${AWS_PROFILE}
                terraform plan -out=tfplan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Apply Terraform changes?'
                sh '''
                export AWS_PROFILE=${AWS_PROFILE}
                terraform apply -auto-approve tfplan
                '''
            }
        }

        stage('Show Outputs') {
            steps {
                sh '''
                terraform output
                '''
            }
        }
    }
}
