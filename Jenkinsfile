pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/haris860/simple-math-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("simple-math-app:latest")
                }
            }
        }

        stage('Run Tests Inside Docker') {
            steps {
                script {
                    dockerImage.inside {
                        bat 'pytest --maxfail=1 --disable-warnings -q --junitxml=tests/pytest-report.xml'
                    }
                }
            }
        }
    }

    post {
        always {
            junit 'tests/pytest-report.xml'
        }
    }
}
