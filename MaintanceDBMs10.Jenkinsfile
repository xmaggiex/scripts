@Library('pipeline-library') _

String dataCenter = 'ms10'
int parts = 2

Map config = readYaml(text: """
triggers:
  - type: cron
    value: 'TZ=Europe/Kiev \nH 07 * * 6'
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
  label: ms9
""")

zPipeline(config) {
    withPipelineSecrets {
        retriveMaintenanceServerListToCsv(dataCenter, "${parts}")
        parallel(
            "MaintenanceDB - #1": { maintenanceSqlServer("1") },
            "MaintenanceDB - #2": { maintenanceSqlServer("2") }
        )
    }
}

Void maintenanceSqlServer(String thread) {
    Map args = [
        Thread: thread
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
