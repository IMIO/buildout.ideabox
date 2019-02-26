@Library('jenkins-pipeline-scripts') _

iasmartwebDeliveryPipeline(
    buildId: "${env.BUILD_ID}",
    imageName: "iasmartweb/ideabox",
    role: 'role::docker::sites$',
    updateScript: 'systemctl restart website-ideabox.service'
)

@Library('jenkins-pipeline-scripts') _
pipeline {
    agent none
    triggers {
        pollSCM('*/3 * * * *')
    }
    options {
        // Keep the 50 most recent builds
        buildDiscarder(logRotator(numToKeepStr:'50'))
    }
    stages {
        stage('Build') {
            agent any
            steps {
                sh 'make docker-image'
            }
        }
        stage('Push image to registry') {
            agent any
            steps {
                pushImageToRegistry (
                    env.BUILD_ID,
                    "iasmartweb/ideabox"
                )
            }
        }
    }
}
