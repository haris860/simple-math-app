pipeline {
    agent any

    environment {
        PYTHONPATH = "${WORKSPACE}"
    }

    stages {
        stage('Clone') {
            steps {
                // Checkout the specified repository and branch
                git branch: 'main', url: 'https://github.com/haris860/simple-math-app.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                // Use a virtual environment
                sh '''
                python -m venv venv
                . venv/Scripts/activate
                pip install -r requirements.txt
                '''
            }
        }

        stage('Run Tests') {
            steps {
                // Run pytest with report generation
                sh '''
                . venv/Scripts/activate
                pytest --maxfail=1 --disable-warnings -q --junitxml=tests/pytest-report.xml
                '''
            }
        }
    }

    post {
        always {
            junit 'tests/pytest-report.xml'
        }
    }
}
