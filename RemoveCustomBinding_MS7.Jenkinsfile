@Library('pipeline-library') _

String dataCenter = 'ms7'

Map config = readYaml(text: """
properties:
  parameters:
  - name: CustomDomain
    type: string
    description: 'Имя кастомного домена.'
  - name: SiteName
    type: string
    description: 'Имя сайта.'
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
        CustomDomain: CustomDomain,
        SiteName: SiteName,
        DataCenter: dataCenter
		]
		
		powershellExecute(
			isStage: true,
			name: "Remove custom binding",
			file: 'PowerShell/TeamCity/metarunner_remove_custom_binding.ps1',
			args: args)
    }
}