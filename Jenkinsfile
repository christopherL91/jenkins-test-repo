pipeline {
    agent {
        kubernetes {
            label "mypod-${UUID.randomUUID().toString()}"
        }
    }
    stages {
        stage('Checkout') {
            checkout scm
        }
        stage('Docker_Setup') {
            sh 'hack/docker_setup.sh'
        }
    }
}
