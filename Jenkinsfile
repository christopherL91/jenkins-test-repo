pipeline {
    agent {
        kubernetes {
            label "mypod-${UUID.randomUUID().toString()}"
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
                sh 'hack/docker_setup.sh'
            }
        }
    }
}
