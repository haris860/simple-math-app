pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'simple-math-app:latest'
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
                        cmd /c "pytest tests/ --junitxml=tests/pytest-report.xml"
                    """
                }
            }
        }
    }

    post {
        always {
            script {
                if (fileExists('tests/pytest-report.xml')) {
                    junit 'tests/pytest-report.xml'
                } else {
                    echo 'Test report not found or could not be generated.'
                }
            }
        }
    }
}
