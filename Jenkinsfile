def label = "mypod-${UUID.randomUUID().toString()}"

pipeline {
    agent {
        kubernetes {
            label: label
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
