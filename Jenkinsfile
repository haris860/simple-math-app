pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'simple-math-app:latest'
        // Update workspace path to be in a format Docker can understand on Windows
        WORKSPACE_PATH = "/workspace"
        VOLUME_PATH = "C:/ProgramData/Jenkins/.jenkins/workspace/simple-math-app-pipeline"
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
                    // Run the container in detached mode and bind the workspace to the container's /workspace
                    // Use correct volume path and working directory in Linux-style path
                    docker.run("${DOCKER_IMAGE}", "-d -t -v ${VOLUME_PATH}:${WORKSPACE_PATH} -w ${WORKSPACE_PATH}") {
                        // No need to manually run pytest as it's handled by CMD in the Dockerfile
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
