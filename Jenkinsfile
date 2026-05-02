pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/MaryamHamood/mern-ecommerce-deployment.git'
            }
        }
        stage('Build & Deploy') {
            steps {
                sh 'docker-compose -f docker-compose.jenkins.yml down || true'
                sh 'docker-compose -f docker-compose.jenkins.yml up -d --build'
                sh 'sleep 10'
            }
        }
        stage('Test') {
            steps {
                sh 'docker rm -f selenium-tests || true'
                sh 'docker build -t selenium-tests https://github.com/MaryamHamood/mern-ecommerce-tests.git#main'
                sh 'docker run --name selenium-tests selenium-tests'
            }
        }
    }
    post {
        always {
            script {
                def pusherEmail = sh(script: "git log -1 --pretty=format:'%ae'", returnStdout: true).trim()
                if (!pusherEmail || !pusherEmail.contains('@') || pusherEmail.contains('compute.internal')) {
                    pusherEmail = 'maryamhamood496@gmail.com'
                }
                emailext(
                    to: pusherEmail,
                    subject: "Jenkins Test Results - ${currentBuild.fullDisplayName}",
                    body: """
Build: ${currentBuild.fullDisplayName}
Status: ${currentBuild.currentResult}
Triggered by: ${pusherEmail}
URL: ${env.BUILD_URL}
                    """
                )
            }
        }
    }
}
