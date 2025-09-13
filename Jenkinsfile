pipeline {
    agent any

    environment {
        NODE_ENV = 'production'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Start npm') {
            steps {
                script{
                    sh"""
                    npm start
                    """
                }
            }
        }

        stage('Test npm') {
            steps {
                script{
                    sh"""
                    npm test
                    """
                }
            }
        }
        
        stage('Staging') {
            when {
                branch 'staging'
            }
            steps {
                script{
                    sh"""
                    chmod +x ./deploy.sh
                    ./deploy.sh staging
                    """
                }
            }
        }

        stage('Production') {
            when {
                branch 'main'
            }
            steps {
                script{
                    sh"""
                    chmod +x ./deploy.sh
                    ./deploy.sh production
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
