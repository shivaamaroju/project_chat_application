pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "shivaamaroju/chat-app-pro"
        CONTAINER_NAME = "chat-app-instance"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/shivaamaroju/project_chat_application.git'
            }
        }

        stage('Build Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:latest ."
            }
        }

        stage('Stop Existing Container') {
            steps {
                script {
                    // This stops and removes the container if it's already running to avoid port conflicts
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"
                }
            }
        }

        stage('Run Container') {
            steps {
                // Runs the container in detached mode on port 8090
                sh "docker run -d --name ${CONTAINER_NAME} -p 8090:8090 ${DOCKER_IMAGE}:latest"
                echo "App is now running at http://localhost:8090"
            }
        }
    }
}
