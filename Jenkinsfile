pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "shivaamaroju/chat-app-pro"
        // This is the ID you will give to your secret file in Jenkins
        KUBE_CONFIG_SECRET_ID = "aks-kubeconfig-file" 
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
                    sh "docker push ${DOCKER_IMAGE}:latest"
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                // withCredentials is a standard method that is definitely in your list!
                withCredentials([file(credentialsId: "${KUBE_CONFIG_SECRET_ID}", variable: 'KUBECONFIG_FILE')]) {
                    script {
                      sh "export KUBECONFIG=${KUBECONFIG_FILE} && kubectl apply -f deployment.yaml"
                sh "export KUBECONFIG=${KUBECONFIG_FILE} && kubectl apply -f service.yaml"
                // కొత్తగా యాడ్ చేస్తున్న లైన్:
                sh "export KUBECONFIG=${KUBECONFIG_FILE} && kubectl apply -f ingress.yaml"
                
                sh "export KUBECONFIG=${KUBECONFIG_FILE} && kubectl rollout restart deployment/chat-app-deployment"
                    }
                }
            }
        }
    }
}
