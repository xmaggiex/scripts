@Library('pipeline-library') _

String dataCenter = 'ms7'

Map config = readYaml(text: """
properties:
  parameters:
  - name: SiteName
    type: string
    description: 'Имя сайта, который будет добавлен в HAProxy.'
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
        Site: SiteName
		]
		
		powershellExecute(
			isStage: true,
			name: "Add site to HAProxy",
			file: 'PowerShell/TeamCity/metarunner_add_site_to_haproxy.ps1',
			args: args)
    }
}