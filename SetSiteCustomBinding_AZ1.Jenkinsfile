@Library('pipeline-library') _

String dataCenter = 'az1'

Map config = readYaml(text: """
properties:
  parameters:
  - name: Domain
    type: string
    description: 'Название кастомного домена.'
  - name: SiteName
    type: string
    description: 'Имя сайта. Нужно для идентификации.'
  - name: PfxFilePath
    type: string
    description: 'Сетевой путь к сертификату.'
  - name: PfxFilePassword
    type: string
    description: 'Пароль к сертификату.'
  - name: ReAddCertificate
    type: boolean
    description: 'Указание на необходимость принудительного обновления сертификата.'
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
		Domain: Domain,
        SiteName: SiteName,
        PfxFilePath: PfxFilePath,
        PfxFilePassword: PfxFilePassword,
        ReAddCertificate: ReAddCertificate
		]
		
    powershellExecute(
      isStage: true,
      name: "Set Site Custom Binding",
      file: 'PowerShell/TeamCity/metarunner_add_custom_binding.ps1',
      args: args)
    
    }
}