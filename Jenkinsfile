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

        stage('Install dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test'
            }
        }

        stage('Build') {
            steps {
                // Добавьте шаги сборки, если нужно (например, babel/webpack), иначе оставьте пустым
                echo 'No build steps defined.'
            }
        }

        stage('Staging') {
            when {
                branch 'staging'
            }
            steps {
                sh 'chmod +x ./deploy.sh'
                sh './deploy.sh staging'
            }
        }

        stage('Production') {
            when {
                branch 'main'
            }
            steps {
                sh 'chmod +x ./deploy.sh'
                sh './deploy.sh production'
            }
        }
    }

    post {
        always {
            // Можно добавить уведомления, чистку, архивирование логов и т.д.
            echo 'Pipeline finished.'
        }
    }
}
