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
        stage('GCP-Setup') {
            steps {
                sh '''
                    sudo mkdir -p /serviceaccounts
                    sudo chown -R jenkins:jenkins /serviceaccounts
                '''
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
                    hack/gcp.sh setup-dev
                    hack/gcp.sh setup-ci
                '''
            }
        }
        stage('Docker build') {
            steps {
                sh '''
                    sudo docker build -t eu.gcr.io/noomi-vnext-ci/hello-world:1.0.0 .

                '''
            }
        }
        stage('Docker push') {
            steps {
                sh '''
                    gcloud config configurations activate noomi-vnext-ci
                    gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin https://eu.gcr.io
                    sudo docker push eu.gcr.io/noomi-vnext-ci/hello-world:1.0.0
                '''
            }
        }
        stage('Kubernetes deployment') {
            steps {
                sh '''
                    gcloud config configurations activate noomi-vnext-dev
                    gcloud container clusters get-credentials be-dev --zone europe-west4-c --project noomi-vnext-dev-202112
                    kubectl apply -f deployment.yaml
                '''
            }
        }
    }
}
