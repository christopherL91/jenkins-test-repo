pipeline {
    agent {
        kubernetes {
            label ""
            inheritFrom "jnlp-slave"
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
                withCredentials([
                    file(credentialsId: 'noomi-vnext-dev', variable: 'FILE')
                ]) {
                    sh 'cat $FILE'
                }
                sh 'hack/setup_docker.sh'
            }
        }
    }
}
