properties([
    parameters ([
        
        choice(name: 'Deployment Target', choices: ['TB-AWS-SS-Dev'], description: 'Choose deployment environment?'),
        string(name: 'Change Number', defaultValue: '', description: 'Enter a ServiceNow Change Number if appropriate')
        
  

    ])
])


pipeline {
    agent any
    options {
    	ansiColor('xterm') // Enables Colour output (useful for things like Ansible)
        
       }
    

    stages {

        stage('Pre-Reqs') {
            steps {
                script{
                    account_id = utils.get_account_id(params['Deployment Target'])
                    withEnv(aws_session.get(account_id, params['Change Number'])) {
                        // here you are in the appropriate account
                        echo "inside withEnv"
                        venv.exec('aws configure set region eu-west-1')
                        venv.exec('aws configure get region')
                    }
                }
            }
        }
       

    }
    post {
        always {
             deleteDir() // Clean up the directory so nothing is left behind
        }
    }
}
