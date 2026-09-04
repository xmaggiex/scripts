@Library('pipeline-library') _

String dataCenter = 'az1'
Map config = readYaml(text: """
triggers:
  - type: cron
    value: 'TZ=Europe/Kiev \n05 07 * * 6'
properties:
  enableGitLabConnection: false
  disableConcurrentBuilds: true
general:
  timeout: 1920
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

        retriveMaintenanceServerListToCsv(dataCenter, "1")
        maintenanceSqlServer("1")
    }
}

Void maintenanceSqlServer(String threat) {
    Map args = [
        Thread: threat
    ]
    powershellExecute(
        isStage: true,
        name: "Maintenance server",
        file: 'PowerShell/TeamCity/metarunner_maintenance_db.ps1',
        args: args)
}

Void retriveMaintenanceServerListToCsv(String dataCenter, String parts) {
    Map args = [
        DataCenter: dataCenter,
        Parts: parts
    ]
    powershellExecute(
        isStage: true,
        name: 'Get servers to maintenance',
        file: 'PowerShell/TeamCity/metarunner_maintenance_db_bc.ps1',
        args: args)
}
