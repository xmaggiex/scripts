@Library('pipeline-library') _

String dataCenter = "ms6"

// TODO: Add lines below to enable triggers
// triggers:
//   - type: cron
//     value: 'TZ=Europe/Kiev \n30 12 * * *'
Map config = readYaml(text: """
general:
  projectName: "Run backuping postgresql clusters"
kubernetes:
  cloud: $dataCenter
  namespace: $dataCenter-jenkins
  containers:
  - containerName: powershell
    image: mcr.microsoft.com/powershell:$POWERSHELL_UNIX_VERSION
    size: small
""")

zPipeline(config) {

  container("powershell") {
    powershellExecute(
      isStage: true,
      name: "Backup cluster",
      file: "PowerShell/Jenkins/metarunner_pgbackrest_run_backuping.ps1",
      args: [DataCenter: dataCenter])
  }
}
