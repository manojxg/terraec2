properties([
    parameters ([
        
        choice(name: 'Deployment Target', choices: ['TB-AWS-SS-Dev'], description: 'Choose deployment environment?'),
        string(name: 'Change Number', defaultValue: '', description: 'Enter a ServiceNow Change Number if appropriate')
        
  

    ])
])


pipeline {
    agent { label 'dba' }
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
       
       
                 
       stage('Do something fun') {
            steps {
                script{
                    account_id = utils.get_account_id(params['Deployment Target'])
                    // withEnv(aws_session.get(account_id, params['Change Number'])) {
                    withEnv(aws_session.get(account_id, params['Change Number'], "arn:aws:iam::${account_id}:role/tb-ss-jenkins-deployment-common") ){
                     //   stopec2instanceid = params['StopEC2']
                        target = params['Deployment Target']
                     //   amiid = params['AMI id']
                     //   keypair = params['Keypair']
                     //   subnetazA = params['subnetstack']
                        // here you are in the appropriate account, test a basic command
                        venv.exec('aws s3 ls')
                        // do something useful
                       // venv.exec("source environment/${target}.sh && env && pwd && ls -la && chmod +x ./fun.sh && chmod +x stopec2.sh")
                       // venv.exec("source environment/${target}.sh && ./stopec2.sh ${stopec2instanceid}")
                       // venv.exec("source environment/${target}.sh && ./fun.sh ${amiid} ${keypair} ${subnetazA}")
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
