@Library('pipeline-library') _

String dataCenter = 'ms6'

Map config = readYaml(text: """
general:
  projectName: "Run backuping postgresql with Linux svc"
  cleanupBeforeBuild: true
  versioningApproach: none
  skipDefaultCheckout: false
kubernetes:
  cloud: $dataCenter
  namespace: $dataCenter-jenkins
  containers:
  - containerName: pgbackrest-restore-worker
    image: bpmonline/pgbackrest-restore-worker:0.5.4
    size: agent
  volumes:
  - type: nfsVolume
    serverAddress: $dataCenter-def-fs01
    serverPath: /NFS-Client/pgbackrest/postgres_linux_backup
    mountPath: /pg_backups
    readOnly: false
""")

zPipeline(config) {
  withPipelineSecrets {

    Map args = [
      Directory: "/pg_backups",
      DBServer: "ms6-v-pg01.ms.bpmonline.com",
      DBPort: "5432",
      DatabaseName: "dev-cflex"
    ]

    container("pgbackrest-restore-worker") {
      powershellExecute(
        isStage: true,
        name: "Backup databases",
        file: 'PowerShell/Jenkins/metarunner_postgres_backup.ps1',
        args: args)
    }
  }
}
