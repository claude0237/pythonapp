#!/bin/sh

application = "pythonapp"
dockerhubaccountid = "claudenkoma"

	echo "Deploy App!"
        docker run -d -p 3333:3333 ${dockerhubaccountid}/${application}:${BUILD_NUMBER}
	echo "Remove old images"
	docker rmi ${dockerhubaccountid}/${application}:latest -f
