pipeline {
  agent any

  environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY') 
  } 
  tools {
    maven 'M2_HOME'
    
    }

  
   stage('Create Docker image of App') {
       steps {
         sh 'docker build -t gopala230390/bank:4.0'
             }
         }

    stage('Docker Image Push') {
       steps {
       withCredentials([usernamePassword(credentialsId: 'dockerpass', passwordVariable: 'dockerpass', usernameVariable: 'dockerhub')]) {
         sh 'docker login -u ${dockerhub} -p ${dockerpass}'
       }
         sh 'docker push gopala230390/bank:4.0'
   }    
     }   
  
    stage('Push Image to DockerHub') {
      steps {
        sh 'docker push gopala230390/bank:4.0'
            }
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
      publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/banking/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
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
             ansiblePlaybook credentialsId: 'AWS-EC2-Key.pem', disableHostKeyChecking: true, installation: 'ansible', inventory: 'inventory', playbook: 'finance-playbook.yml'
           }
               }
     }
 
}
  
