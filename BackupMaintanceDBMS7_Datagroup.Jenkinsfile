@Library('pipeline-library') _

String dataCenter = 'ms7'
String site = 'datagroup'
String backupDir = "\\\\${dataCenter}-def-store01\\${dataCenter}-store\\Client\\SQLDailyBackup"

Map config = readYaml(text: """
triggers:
  - type: cron
    value: 'TZ=Europe/Kiev \n30 22 * * *'
properties:
  enableGitLabConnection: false
  disableConcurrentBuilds: true
general:
  timeout: 450
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
		maintenanceSqlSite(site)
    }
}

Void backupDatabase(String site, String backupDir) {    
    Map backupDbArgs = [
        Site: site,
        BackupDbDirectory: backupDir
    ]
    powershellExecute(
        isStage: true,
        name: "Backup databases",
        file: 'PowerShell/TeamCity/metarunner_daily_backup_site_db.ps1',
        args: backupDbArgs)
}

Void maintenanceSqlSite(String site) {
    Map args = [
        Site: site
    ]
    powershellExecute(
        isStage: true,
        name: "Maintenance server",
        file: 'PowerShell/TeamCity/metarunner_maintenance_site_db.ps1',
        args: args)
}
