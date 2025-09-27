pipeline {
    agent any

    environment {
        AWS_PROFILE = "myprofile"   // 👈 use profile name
    }


parameters {
    string(name: 'SUBNET_ID', defaultValue: 'subnet-0e71381a11f27c2c4', description: 'AWS Subnet ID')
    string(name: 'SECURITY_GROUP_ID', defaultValue: 'sg-0cf62ab6398dbaba9', description: 'AWS Security Group')
}

stages {
    stage('Terraform Plan') {
        steps {
            sh '''
            export AWS_PROFILE=${AWS_PROFILE}
            terraform plan -var="subnet_id=${SUBNET_ID}" -var="security_group_id=${SECURITY_GROUP_ID}" -out=tfplan
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
}
