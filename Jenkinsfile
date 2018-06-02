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
                sh '''
                    sudo mkdir -p /serviceaccounts
                    sudo chown -R jenkins:jenkins /serviceaccounts
                '''
            }
        }
        stage('GCP-Setup') {
            steps {
                withCredentials([
                    file(credentialsId: 'noomi-vnext-ci', variable: 'GCSKEY')
                ]) {
                        sh 'cp ${GCSKEY} /serviceaccounts/noomi-vnext-ci.json'
                }
                withCredentials([
                    file(credentialsId: 'noomi-vnext-dev', variable: 'GCSKEY')
                ]) {
                        sh 'cp ${GCSKEY} /serviceaccounts/noomi-vnext-dev.json'
                }

                sh '''
                    ls -li /serviceaccounts
                    cat /serviceaccounts/noomi-vnext-ci.json
                    cat /serviceaccounts/noomi-vnext-dev.json
                    hack/gcp.sh setup-dev
                    hack/gcp.sh setup-ci
                '''
            }
        }
        stage('Docker pull') {
            steps {
                sh '''
                    gcloud config configurations activate noomi-vnext-ci
                    export GOOGLE_APPLICATION_CREDENTIALS=/serviceaccounts/noomi-vnext-ci.json
                    gcloud config configurations activate noomi-vnext-ci
                    gcloud auth configure-docker --quiet
                    sudo docker pull eu.gcr.io/noomi-vnext-ci/jnlp-slave:1.0.0
                '''
            }
        }
    }
}
