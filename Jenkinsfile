pipeline {
  agent any

  tools {
    maven 'M2_HOME'
    
    }
 
  
   stages {
   stage('CheckOut') {
      steps {
        echo 'Checkout the source code from GitHub'
        git branch: 'main', url: 'https://github.com/Gopala230390/Banking.git'
            }
    }
    
    stage('Package the Application') {
      steps {
        echo " Packaing the Application"
        sh 'mvn clean package'
            }
    }
    
    stage('Publish Reports using HTML') {
      steps {
      publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Banking/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
    }
    
        stage ('Configure Test-server with Terraform, Ansible and then Deploying'){
            steps {
                dir('my-serverfiles'){
                sh 'sudo chmod 600 AWS-EC2-Key.pem'
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform apply --auto-approve'
                }
            }
        }
        stage ('Deploy into test-server using Ansible') {
           steps {
             ansiblePlaybook credentialsId: 'BabucKeypair', disableHostKeyChecking: true, installation: 'ansible', inventory: 'inventory', playbook: 'finance-playbook.yml'
           }
               }
     }
 
}
  
