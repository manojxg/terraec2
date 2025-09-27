properties([
    parameters ([
        string(name: 'StopEC2', defaultValue:'',description: 'Enter the instance id to stop12try2'),
        choice(name: 'Deployment Target', choices: ['TB-AWS-SS-Dev'], description: 'Choose deployment environment?'),
        string(name: 'Change Number', defaultValue: '', description: 'Enter a ServiceNow Change Number if appropriate'),
        string(name: 'AMI id', defaultValue: '', description: 'Enter the id of the AMI that you wish to start'),
        string(name: 'Keypair', defaultValue: '', description: 'Enter the name of the keypair to use for the instance'),
  // choice(name: 'subnetstack', choiceType: 'PT_RADIO', choices: ['subnet-00f3469054725588e', 'subnet-0b543bc371221eb24' , 'subnet-072b81ff6f0f409d0'], description: 'Choose "subnet-07c3db60" to move into AZ-A and "subnet-74a9463c"  to move into AZ-B, where instance to deploy'),
 //       choice(name: 'DeployTo', description: 'Select the environment to deploy to', type: 'PT_RADIO', value: 'Dev,Test,Stage', visibleItemCount: 5),
    //     choice(name: 'subnetstack', choices: ['A','B','C' ], description: 'Choose environment'),
                choice(
            name: 'SUBNET_STACK',
            choices: ['A', 'B', 'C'],
            description: 'Select subnet stack'
        )


    ])
])

node {
    def subnetStack = params.SUBNET_STACK

    if (subnetStack == 'A') {
        println "Using Subnet Stack A"
        // Logic for Stack A
    } 
    else if (subnetStack == 'B') {
        println "Using Subnet Stack B"
        // Logic for Stack B
    } 
    else if (subnetStack == 'C') {
        println "Using Subnet Stack C"
        // Logic for Stack C
    } 
    else {
        error "Invalid selection!"
    }
}

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
                        stopec2instanceid = params['StopEC2']
                        target = params['Deployment Target']
                        amiid = params['AMI id']
                        keypair = params['Keypair']
                        subnetazA = params['subnetstack']
                        // here you are in the appropriate account, test a basic command
                        venv.exec('aws s3 ls')
                        // do something useful
                        venv.exec("source environment/${target}.sh && env && pwd && ls -la && chmod +x ./fun.sh && chmod +x stopec2.sh")
                        venv.exec("source environment/${target}.sh && ./stopec2.sh ${stopec2instanceid}")
                        venv.exec("source environment/${target}.sh && ./fun.sh ${amiid} ${keypair} ${subnetazA}")
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
