@Library('pipeline-library') _

String dataCenter = 'ms7'

Map config = readYaml(text: """
properties:
  parameters:
  - name: dataCenter
    type: string
    description: 'Датацентр.'
  enableGitLabConnection: false
  disableConcurrentBuilds: true
general:
  cleanupBeforeBuild: true
  versioningApproach: none
  skipDefaultCheckout: false
kubernetes:
  enabled: false
agent:
  label: $dataCenter
""")

zPipeline(config) {
    withPipelineSecrets {

    def cause = currentBuild.getBuildCauses('hudson.model.Cause$UserIdCause')
    def userID = cause.userId
			
		Map args = [
	dataCenter : dataCenter
		]
		
    powershellExecute(
      isStage: true,
      name: "Actualize S3 Storage Size",
      file: 'PowerShell/Actualize-S3BucketsSize.ps1',
      args: args)
    
    }
}