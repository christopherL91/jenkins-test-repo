pipeline {
    agent {
        label "mypod-${UUID.randomUUID().toString()}"
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
