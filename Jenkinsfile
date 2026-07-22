pipeline {
    agent any

    environment {
        IMAGE_NAME = "to-do-app"
        CONTAINER_NAME = "to-do-app"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                    docker stop $CONTAINER_NAME || true
                    docker rm $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                    docker run -d \
                    --name $CONTAINER_NAME \
                    -p 8000:8000 \
                    $IMAGE_NAME
                '''
            }
        }

        stage('Smoke Test') {
            steps {
                sh '''
                    sleep 10
                    curl http://localhost:8000
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment Successful!"
        }

        failure {
            echo "❌ Deployment Failed!"
        }

        always {
            sh 'docker ps -a'
        }
    }
}
