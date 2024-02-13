node {
def application = "pythonapp"
def dockerhubaccountid = "claudenkoma"
	stage("Deploy SpringBoot App!") {
        sshCommand remote: remote, command: 'docker run -d -p 3333:3333 ${dockerhubaccountid}/${application}:${BUILD_NUMBER}'}
	stage('Remove old images') {
	sshCommand remote: remote, command: 'docker rmi ${dockerhubaccountid}/${application}:latest -f'
        }
}
