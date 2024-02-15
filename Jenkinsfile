pipeline {
    agent any
 stages {
  stage('Docker Build and Tag') {
           steps {
              
                sh 'docker build -t pythonapp:latest .' 
                  sh 'docker tag pythonapp claudenkoma/pythonapp:latest'
                sh 'docker tag pythonapp claudenkoma/pythonapp:$BUILD_NUMBER'
               
          }
        }
     
  stage('Publish image to Docker Hub') {
          
            steps {
        withDockerRegistry([ credentialsId: "dockerHub", url: "" ]) {
          sh  'docker push claudenkoma/pythonapp:latest'
          sh  'docker push claudenkoma/pythonapp:$BUILD_NUMBER' 
        }
                  
          }
        }
     
      stage('Run Docker container on Jenkins Agent') {
             
            steps {
                sh "docker run -d -p 4030:80 claudenkoma/pythonapp"
 
            }
        }
 stage('Run Docker container on remote hosts') {
             
            steps {
                sh "docker -H ssh://softtech@10.12.1.139 -i softtech-priv-key-139  run -d -p 4001:80 claudenkoma/pythonapp"
 
            }
        }
    }
}
