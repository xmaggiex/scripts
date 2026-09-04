@Library('pipeline-library') _

String dataCenter = 'ms1'
String sourceDirectory = "\\\\${dataCenter}-def-fs01\\DFS-MS-SQLDailyBackup-${dataCenter}\\Client\\"
String clientBackupDir = "\\\\${dataCenter}-def-fs01\\DFS-MS-SQLDailyClientBackup-${dataCenter}\\Client\\"
Map config = readYaml(text: """
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
  label: $dataCenter
""")

zPipeline(config) {
    withPipelineSecrets {
        Boolean isItClient = JOB_NAME.contains('Client')
        String directoryValue = isItClient ? clientBackupDir : sourceDirectory
        String age = 2
        String filter = '*.bak; *.zip; *.gz; *.dump; *.backup;'
        String storageAccountName = "backupaustralia1"
        String storageDirectory = "SQLDailyBackup/Client"
        removeOldBackups(directoryValue, dataCenter, age, filter, storageAccountName, storageDirectory)
    }
}

Void removeOldBackups(String directory, String dataCenter, String age, String filter, String storageAccountName, String storageDirectory) {
    Map args = [
        Age: age,
        Filter: filter,
        AzureObjectKey: storageDirectory,
        StorageAccountName: storageAccountName,
        ContainerName: "${dataCenter}-store",
        Directory: directory
    ]
    powershellExecute(
        isStage: true,
        name: 'Remove old backups',
        file: 'PowerShell/TeamCity/metarunner_delete_old_backups_azure.ps1',
        args: args)
}
