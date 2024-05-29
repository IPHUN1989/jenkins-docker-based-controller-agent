pipeline {
    agent {
        docker {
            image 'node:18.20.3-slim'
        }
    }
    stages {
        stage('Version') {
            steps {
                sh 'node --version'
            }
        }
    }
}