@Library('pipeline-library') _

String dataCenter = "ms1"

Map config = readYaml(text: """
general:
  projectName: "Backup postgresql cluster"
properties:
  parameters:
    - name: PGHost
      type: string
      description: "PostgreSQL host, e.g. 'ms1-x-pg01'"
    - name: BackupType
      type: choice
      choices: ["full", "diff", "incr"]
kubernetes:
  cloud: $dataCenter
  namespace: $dataCenter-jenkins
  containers:
  - containerName: pgbackrest
    image: bpmonline/pgbackrest:$PG_BACKREST_VERSION
    size: medium
""")

zPipeline(config) {
    if(!params.PGHost || !params.BackupType) {
        throw new Exception("The parameters 'PrivateKey' and 'DataCenter' must be provided.")
    }
    container("pgbackrest") {
        powershellExecute(
            isStage: true,
            name: "Backup cluster",
            file: "PowerShell/Jenkins/metarunner_pgbackrest_backup.ps1",
            args: [DataCenter: dataCenter, PGHost: params.PGHost, BackupType: params.BackupType])
    }
}
