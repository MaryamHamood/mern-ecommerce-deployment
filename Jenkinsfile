pipeline {
    agent any
    stages {
        stage('Cleanup') {
            steps {
                // Stops any old version of the app to prevent port conflicts
                sh 'docker rm -f mern-app-automated || true'
            }
        }
        stage('Checkout') {
            steps {
                // Pulls your latest code from GitHub
                git 'https://github.com/MaryamHamood/mern-ecommerce-deployment.git'
            }
        }
        stage('Deploy') {
            steps {
                // Starts the app using your docker-compose.yml
                sh 'docker-compose up -d'
            }
        }
    }
}