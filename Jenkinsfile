pipeline {
    agent {
        kubernetes {
            label "jnlp-slave"
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
                    file(credentialsId: 'noomi-vnext-ci', variable: 'GCSKEY')
                ]) {
                    sh "hack/gcp.sh setup-ci"
                }
                sh '''
                    hack/gcp.sh use-ci
                    env
                    hack/docker.sh configure-docker-helper
                    sudo docker pull eu.gcr.io/noomi-vnext-ci/jnlp-slave:1.0.0
                '''
            }
        }
    }
}
