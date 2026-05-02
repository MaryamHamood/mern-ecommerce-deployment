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
                sh 'docker build -t selenium-tests https://github.com/MaryamHamood/mern-ecommerce-tests.git'
                sh 'docker run --name selenium-tests selenium-tests'
            }
        }
    }
    post {
        always {
            mail to: "${env.GIT_COMMITTER_EMAIL ?: 'maryamhamood496@gmail.com'}",
                subject: "Jenkins Test Results - ${currentBuild.fullDisplayName}",
                body: """
Build: ${currentBuild.fullDisplayName}
Status: ${currentBuild.currentResult}
URL: ${env.BUILD_URL}

Check Jenkins for full test report.
                """
        }
    }
}
