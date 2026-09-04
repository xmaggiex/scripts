@Library('pipeline-library') _

String dataCenter = 'ms7'

Map config = readYaml(text: """
properties:
  parameters:
  - name: SiteName
    type: string
    description: 'Имя сайта, который будет удалён из HAProxy.'
  enableGitLabConnection: false
  disableConcurrentBuilds: true
general:
  timeout: 1440
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

		Map args = [
        Site: SiteName,
        DataCenter: dataCenter
		]
		
		powershellExecute(
			isStage: true,
			name: "Remove site from HAProxy",
			file: 'PowerShell/TeamCity/metarunner_remove_site_from_haproxy.ps1',
			args: args)
    }
}