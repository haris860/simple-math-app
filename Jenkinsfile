pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'simple-math-app:latest'
        WORKSPACE_PATH = "/c/ProgramData/Jenkins/.jenkins/workspace/simple-math-app-pipeline"
        VOLUME_PATH = "/c/ProgramData/Jenkins/.jenkins/workspace/simple-math-app-pipeline"
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
                    // Build the Docker image using the Dockerfile
                    dockerImage = docker.build(DOCKER_IMAGE, "-f Dockerfile .")
                }
            }
        }

        stage('Run Tests Inside Docker') {
            steps {
                script {
                    // Run the container and let the CMD ["pytest"] in the Dockerfile handle the test execution
                    dockerImage.inside("-d -t -w ${WORKSPACE_PATH} -v ${VOLUME_PATH}:/workspace") {
                        // No need to run pytest again; Dockerfile CMD will automatically run pytest
                        echo 'Running tests inside the container (via CMD in Dockerfile)...'
                    }
                }
            }
        }
    }

    post {
        always {
            // Always archive the test results to Jenkins
            junit 'tests/pytest-report.xml'
        }
    }
}
