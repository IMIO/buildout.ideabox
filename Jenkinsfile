@Library('jenkins-pipeline-scripts') _
pipeline {
    agent any
    triggers {
        pollSCM('*/3 * * * *')
    }
    stages {
        stage('Build') {
            steps {
                sh 'make docker-image'
            }
        }
        stage('Push image to registry') {
            steps {
                pushImageToRegistry (
                    "${env.BUILD_ID}",
                    "iasmartweb/ideabox"
                )
            }
        }
        stage('Deploy to staging') {
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                deployToStaging (
                    "${env.BUILD_ID}",
                    "iasmartweb/ideabox",
                    'role::docker::sites$',
                    'systemctl restart website-ideabox.service'
                )
            }
        }
        stage('Deploy to Prod') {
            input {
                message "Should we deploy to prod ?"
            }
            steps {
                deployToProd (
                    "${env.BUILD_ID}",
                    "iasmartweb/ideabox",
                    'role::docker::sites$',
                    '/srv/docker_scripts/website-update-all-images.sh'
                )
            }
        }
    }
}
