pipeline {
    agent any

    environment {
        AWS_REGION = "eu-west-1"
        ROLE_ARN   = "arn:aws:iam::773493560304:role/Super_user"
    }

    stages {
        stage('Assume Role') {
            steps {
                script {
                    echo "🔑 Assuming AWS Role via STS..."

                    // Run AWS STS assume-role command and capture JSON
                    def credsJson = sh(
                        script: """
                            aws sts assume-role \
                              --role-arn ${ROLE_ARN} \
                              --role-session-name jenkins-session \
                              --output json
                        """,
                        returnStdout: true
                    ).trim()

                    echo "✅ STS Assume Role executed successfully"

                    // Parse JSON output
                    def creds = readJSON text: credsJson

                    // Export credentials to environment
                    env.AWS_ACCESS_KEY_ID     = creds.Credentials.AccessKeyId
                    env.AWS_SECRET_ACCESS_KEY = creds.Credentials.SecretAccessKey
                    env.AWS_SESSION_TOKEN     = creds.Credentials.SessionToken

                    // Optional for Terraform variable passing
                    env.TF_VAR_aws_access_key_id     = env.AWS_ACCESS_KEY_ID
                    env.TF_VAR_aws_secret_access_key = env.AWS_SECRET_ACCESS_KEY
                    env.TF_VAR_aws_session_token     = env.AWS_SESSION_TOKEN

                    echo "🔐 Temporary credentials set in environment"
                }
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                    echo "🚀 Initializing Terraform..."
                    terraform init
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh '''
                    echo "⚙️ Applying Terraform plan..."
                    terraform apply -auto-approve
                '''
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
