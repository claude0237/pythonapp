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
		 sshCommand remote: remote, command: 'docker run -d -p 3333:3333 ${dockerhubaccountid}/${application}:${BUILD_NUMBER}'
		}	  
		  
	stage('Remove old images') {
	sshCommand remote: remote, command: 'docker rmi ${dockerhubaccountid}/${application}:latest -f'
	}
        
    }
}
