pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "shivaamaroju/chat-app-pro"
        // Ensure you have a 'kubeconfig' secret stored in Jenkins
        KUBE_CONFIG_ID = "aks-kubeconfig" 
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/shivaamaroju/project_chat_application.git'
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:latest ."
                    // You must be logged into Docker Hub on the Jenkins node
                    sh "docker push ${DOCKER_IMAGE}:latest"
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                // This uses the Jenkins Kubernetes CLI plugin or a pre-configured kubeconfig
                withKubeConfig([credentialsId: "${KUBE_CONFIG_ID}"]) {
                    sh "kubectl apply -f deployment.yaml"
                    sh "kubectl apply -f service.yaml"
                    
                    // Force a restart to pull the 'latest' image if it hasn't changed tags
                    sh "kubectl rollout restart deployment/chat-app-deployment"
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh "kubectl get pods"
                sh "kubectl get service chat-app-service"
            }
        }
    }
}
