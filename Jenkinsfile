pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
            }
        }
        stage('Build') {
            steps {
                echo 'Building the project...'
                sh 'echo "Compiling source files..."'
            }
        }
        stage('Test') {
            steps {
                echo 'Running unit tests...'
                sh 'echo "All tests passed!"'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                sh 'echo "Deployment successful!"'
            }
        }
    }
}
