pipeline {
    agent {
        kubernetes {
            label "mypod-${UUID.randomUUID().toString()}"
            defaultContainer 'jnlp'
        }
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Docker_Setup') {
            steps {
                sh 'hack/setup_docker.sh'
            }
        }
    }
}
