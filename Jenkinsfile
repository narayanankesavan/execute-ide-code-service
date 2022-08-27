pipeline {
  environment {
    registry = "nara1983/jenkinsdockerimage"
    DOCKERHUB_CREDENTIALS=credentials('dockerhub')
    dockerImage = 'execute-code'
    containername = 'execute-code'
    MAIL_TO ='kesavannarayanan@gmail.com,lobomalcon@gmail.com,sangramsahutech@gmail.com,anshulv1401@gmail.com,akshit.baunthy@gmail.com'
	PORT='9001'
  }
  agent {label 'backendapi-java'}
  stages {
	stage('Maven Build') {
      steps{
        sh 'echo inside maven build'
        sh 'ls -al'
        dir("${env.WORKSPACE}"){
        sh 'echo inside dir'
        sh "pwd"
        sh 'mvn clean install'
        }
      }
    }
	stage('Remove Docker container') {
      steps{
		script {
			def contid = sh(script: "sudo docker ps --no-trunc -aqf name=${containername}",returnStdout: true)
                        echo "contid: " + "${contid}"
			if("${contid}" != ''){
			    sh "echo inside delete container"
				sh "sudo docker rm -f ${contid}"
			}
		 }
      }
    }
	stage('Remove Docker image') {
      steps{
	  dir("${env.WORKSPACE}"){
		script {
			def imageExists = sh(script: "sudo docker images -q ${registry}:${dockerImage}",returnStdout: true)
            echo "Image Name: " + "${imageExists}"
			if("${imageExists}" != ''){
			    sh "echo inside delete block"
				sh "sudo docker rmi ${imageExists}"
			}
		 }
		}
      }
    }
	stage('Building Docker image') {
      steps{
	  dir("${env.WORKSPACE}"){
		sh "pwd"
		sh 'sudo docker build -f Dockerfile -t ${registry}:${dockerImage} .'
		}
      }
    }
	stage('Run Docker container') {
      steps{
	  script {
		sh "pwd"
		sh "sudo docker run -it -d --name ${containername} -p ${PORT}:${PORT} ${registry}:${dockerImage}"
		}
      }
    }
	 stage('Push to Docker Hub') {
      steps{
        script {
          sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
          sh 'docker push $registry:$dockerImage'
         
        }
      }
    }
   }
	post{
        always{
	    mail to:"${MAIL_TO}",
            subject: "Capstone Project-Bankend API-jenkins build:${currentBuild.currentResult}: ${env.JOB_NAME}",
            body: "${currentBuild.currentResult}: Job ${env.JOB_NAME}\n More Info can be found here: ${env.BUILD_URL}"
	   /*emailext to: "kesavannarayanan@gmail.com",
            subject: "Capston Project-Bankend API-jenkins build:${currentBuild.currentResult}: ${env.JOB_NAME}",
            body: "${currentBuild.currentResult}: Job ${env.JOB_NAME}\n More Info can be found here: ${env.BUILD_URL}"*/
        }
    }
 }
