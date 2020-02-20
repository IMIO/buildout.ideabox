@Library('jenkins-pipeline-scripts') _

pipeline {
    agent none
    options {
        buildDiscarder(logRotator(numToKeepStr:'30'))
    }
    stages {
        stage('Build') {
            agent any
            steps {
                sh 'make eggs'
                sh 'make docker-image'
            }
        }
        stage('Push image to registry') {
            agent any
            steps {
                sh "docker tag ideabox/mutual:5.2.1 docker-staging.imio.be/ideabox/mutual:5.2.1"
                sh "docker tag ideabox/mutual:5.2.1 docker-staging.imio.be/ideabox/mutual:5.2.1-$BUILD_ID"
                sh "docker push docker-staging.imio.be/ideabox/mutual:5.2.1"
                sh "docker push docker-staging.imio.be/ideabox/mutual:5.2.1-$BUILD_ID"
            }
        }
        stage('Deploy to staging') {
            agent any
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                sh "mco shell run 'docker pull docker-staging.imio.be/ideabox/mutual:5.2.1-$BUILD_ID' -I /^staging.imio.be/"
                sh "mco shell run 'systemctl restart website-ideabox.service' -I /^staging.imio.be/"
            }
        }
    }
    post {
        always {
            node(null)  {
                sh "rm -rf eggs/"
            }
        }
    }
}
