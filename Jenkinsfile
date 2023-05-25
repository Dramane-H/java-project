pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dramzy31')
    REMOTE_SERVER = '35.181.44.26'
    REMOTE_USER = 'ubuntu'            
  }
  

  // Fetch code from GitHub

  stages {
    stage('checkout') {
      steps {
        git branch: 'week-3', url: 'https://github.com/Dramane-H/java-project'

      }
    }


   // Build Java application
   

    stage('Maven Build') {
      steps {
        sh 'mvn clean install'
      }

     // Post building archive Java application

      post {
        success {
          archiveArtifacts artifacts: '**/target/*.jar'
        }
      }
    }

  // Test Java application

    stage('Maven Test') {
      steps {
        sh 'mvn test'
      }
    }

   // Build docker image in Jenkins

    stage('Build Docker Image') {

      steps {
        sh 'docker build -t java-webapp:latest .'
        sh 'docker tag java-webapp dramzy31/java-webapp:latest'
      }
    }

   // Login to DockerHub before pushing docker Image

    stage('Login to DockerHub') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u    $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }

   // Push image to DockerHub registry

    stage('Push Image to dockerHUb') {
      steps {
        sh 'docker push dramzy31/java-webapp:latest'
      }
      post {
        always {
          sh 'docker logout'
        }
      }

    }

   // Pull docker image from DockerHub and run in EC2 instance 

stage('Deploy Docker image to AWS instance') {
    steps {
        script {
            sshagent(credentials: ['awscred']) {
                sh """
                    ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_SERVER} << EOF
                    set -e
                    
                    docker stop java-webapp || true
                    docker rm java-webapp || true
                    docker pull dramzy31/java-webapp
                    docker run --name java-webapp -d -p 8081:8081 dramzy31/java-webapp
                    EOF
                """
            }
        }
    }
}
