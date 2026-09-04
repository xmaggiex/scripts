@Library('pipeline-library') _

String dataCenter = 'ms1'

Map config = readYaml(text: """
properties:
  parameters:
  - name: PG_Username
    type: string
    description: 'Пользователь PostgreSQL сервера'
  - name: PG_Servername
    type: string
    description: 'Название PostgreSQL сервера'
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
		RevokePGSuperuser(PG_Username, PG_Servername)
    }
}

Void RevokePGSuperuser(String user, String server) {
    Map args = [
        PGUserName: user,
		PGServer: server
    ]
    powershellExecute(
        isStage: true,
        name: "Revoke PG Superuser",
        file: 'PowerShell/TeamCity/metarunner_revoke_pg_superuser.ps1',
        args: args)
}