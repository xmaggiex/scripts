@Library('pipeline-library') _

String dataCenter = 'ms7'

Map config = readYaml(text: """
properties:
  parameters:
  - name: SiteName
    type: string
    description: 'Имя сайта. Нужно для идентификации.'
  - name: RecycleTime
    type: string
    description: 'Время переработки пула приложений IIS в формате ЧЧ:мм:сс (например, 23:00:00).'
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
        SiteName: SiteName,
        RecycleTime: RecycleTime
        ]

    powershellExecute(
      isStage: true,
      name: "Set Site Recycle Time",
      file: 'PowerShell/Set-SiteRecycleTime.ps1',
      args: args)

    }
}
