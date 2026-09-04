@Library('pipeline-library') _

String dataCenter = 'ua2'
Map config = readYaml(text: """
triggers:
  - type: cron
    value: 'TZ=Europe/Kiev \n00 3 * * *'
properties:
  enableGitLabConnection: false
  disableConcurrentBuilds: true
general:
  timeout: 115
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

        maintenanceSqlSite("datagroup")
    }
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
