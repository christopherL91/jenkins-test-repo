// this guarantees the node will use this template
def label = "mypod-${UUID.randomUUID().toString()}"
podTemplate(label: label) {
    node(label) {
        stage('Checkout') {
            checkout scm
        }
        stage('Run shell') {
            sh 'ls -li'
        }
    }
}
