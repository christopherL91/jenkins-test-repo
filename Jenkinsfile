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
                sh "sudo mkdir -p /serviceaccounts"
            }
        }
        stage('GCP-Setup') {
            steps {
                withCredentials([
                    file(credentialsId: 'noomi-vnext-ci', variable: 'GCSKEY')
                ]) {
                        sh 'sudo cp ${GCSKEY} /serviceaccounts/noomi-vnext-ci.json'
                }
                withCredentials([
                    file(credentialsId: 'noomi-vnext-dev', variable: 'GCSKEY')
                ]) {
                        sh 'sudo cp ${GCSKEY} /serviceaccounts/noomi-vnext-dev.json'
                }

                sh '''
                    sudo ls -li /serviceaccounts
                    sudo cat /serviceaccounts/noomi-vnext-ci.json
                    sudo cat /serviceaccounts/noomi-vnext-dev.json
                    hack/gcp.sh setup-dev
                    hack/gcp.sh setup-ci
                '''
            }
        }
        stage('Docker pull') {
            steps {
                sh '''
                    hack/gcp.sh use-ci
                    echo ${GOOGLE_APPLICATION_CREDENTIALS}
                    hack/docker.sh configure-docker-helper
                    sudo docker pull eu.gcr.io/noomi-vnext-ci/jnlp-slave:1.0.0
                '''
            }
        }
    }
}
