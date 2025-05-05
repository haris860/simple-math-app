pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'simple-math-app:latest'
        // Adjust to your Jenkins workspace if needed
        VOLUME_PATH = '/c/ProgramData/Jenkins/.jenkins/workspace/simple-math-app-pipeline'
        WORKSPACE_PATH = '/workspace'
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/haris860/simple-math-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    bat "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Run Tests Inside Docker') {
            steps {
                script {
                    bat """
                        docker run --rm ^
                        -v ${VOLUME_PATH}:${WORKSPACE_PATH} ^
                        -w ${WORKSPACE_PATH} ^
                        ${DOCKER_IMAGE} ^
                        pytest tests/ --junitxml=tests/pytest-report.xml
                    """
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
