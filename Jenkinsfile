node {
    def application = "pythonapp"
    def dockerhubaccountid = "claudenkoma"
	def remote = [:]
	remote.name = "softtech"
	remote.host = "10.12.1.139"
	remote.allowAnyHosts = true
	
    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        app = docker.build("${dockerhubaccountid}/${application}:${BUILD_NUMBER}")
    }

    stage('Push image') {
        withDockerRegistry([ credentialsId: "dockerHub", url: "" ]) {
        app.push()
        app.push("latest")
    }
    }
   stage("Deploy App!") {
     withCredentials([sshUserPrivateKey(credentialsId: 'softtech-priv-key-139', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'softtech')]) {
     remote.user = softtech
     remote.identityFile = identity
     sshCommand remote: remote, command: 'mkdir deployment', failOnError:'false'
     sshCommand remote: remote, command: 'rm /home/jenkins/deployment/deploy.sh', failOnError:'false'
     sshPut remote: remote, from: 'deploy.sh', into: '/home/softtech/deployment'
     sshCommand remote: remote, command: 'cd /home/jenkins/deployment; chmod 777 deploy.sh;./deploy.sh'
    }	     
    }
	
}
