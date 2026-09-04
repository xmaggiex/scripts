@Library('pipeline-library') _

String dataCenter = 'ms13'
String buildNumber = currentBuild.number
String outDirectory = "\\\\ms7-def-fs01\\MngOutput\\ms13-MaintananceDb"

Map config = readYaml(text: """
properties:
  parameters:
  - name: dataCenter
    type: string
    description: 'dataCenter.'
  - name: outDirectory
    type: string
    description: 'outDirectory for logs.'
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
	dataCenter : dataCenter,
	outDirectory : outDirectory
		]
		
    powershellExecute(
      isStage: true,
      name: "Maintanance PostgreSQL databases",
      file: 'PowerShell/TeamCity/metarunner_maintenance_db_postgresql.ps1',
      args: args)
    
    }
}