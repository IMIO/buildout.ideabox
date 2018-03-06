@Library('jenkins-pipeline-scripts') _

iasmartwebDeliveryPipeline(
    buildId: "${env.BUILD_ID}",
    imageName: "iasmartweb/ideabox",
    role: 'role::docker::sites$',
    updateScript: 'systemctl restart website-ideabox.service'
)
