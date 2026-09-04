@Library('pipeline-library') _

String datacenter = 'az1'
String trialBackupDir = "\\\\${datacenter}-def-fs01\\NFS\\SQLDailyBackup-${datacenter}\\Client\\"
String clientBackupDir = "\\\\${datacenter}-def-fs01\\NFS-Client\\SQLDailyClientBackup-${datacenter}\\Client\\"
Map config = readYaml(text: """
triggers:
  - type: cron
    value: 'TZ=Europe/Kiev \n05 02 * * *'
properties:
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
  label: $datacenter
""")

zPipeline(config) {
    withPipelineSecrets {
        Boolean isItClient = JOB_NAME.contains('Client')
        def typeOfSiteValue = isItClient ? 'Client' : 'Trial'
        def clientDatabaseBackupDirectoryValue = isItClient ? clientBackupDir : trialBackupDir

        backupPosgtreSQL(typeOfSiteValue, clientDatabaseBackupDirectoryValue, datacenter)
    }
}

Void backupPosgtreSQL(String typeOfSite, String clientDatabaseBackupDirectory, String datacenter) {
    Map args = [
        ClientDatabaseBackupDirectory: clientDatabaseBackupDirectory,
        TypeOfSite: typeOfSite,
        Datacenter: datacenter
    ]
    powershellExecute(
        isStage: true,
        name: "Backup postgresql databases",
        file: 'PowerShell/TeamCity/metarunner_backup_postgres_db.ps1',
        args: args)
}
