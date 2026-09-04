@Library('pipeline-library') _

String dataCenter = "ms6"

Map config = readYaml(text: """
general:
  projectName: "Backup postgresql cluster"
properties:
  parameters:
  - name: PGHost
    type: string
    description: "PostgreSQL host, e.g. 'ms6-x-pg01'"
    defaultValue: "ms6-test-pg01"
  - name: BackupType
    type: choice
    choices: ["full", "diff", "incr"]
kubernetes:
  cloud: $dataCenter
  namespace: $dataCenter-jenkins
  workspaceVolumeInMemory: true
  containers:
  - containerName: pgbackrest
    image: bpmonline/pgbackrest-backup-worker:0.5.4
    size: medium
  volumes:
  - type: nfsVolume
    serverAddress: ms6-test-pgbackrest
    serverPath: /opt/nfs/pgbackrest
    mountPath: /pgbackrest
    readOnly: false
""")

zPipeline(config) {
  if(!params.PGHost || !params.BackupType) {
      throw new Exception("The parameters 'PGHost' and 'BackupType' must be provided.")
  }

  container("pgbackrest") {
    try {
      powershellExecute(
        isStage: true,
        name: "Backup cluster",
        file: "PowerShell/Jenkins/metarunner_pgbackrest_backup.ps1",
        args: [
          DataCenter: dataCenter,
          PGHost: params.PGHost,
          BackupType: params.BackupType,
          LogDirectory: WORKSPACE
        ]
      )
    } finally {
      sh "find ${WORKSPACE} -maxdepth 1 -name '*.log' -exec chmod 755 {} \\;"
      archiveArtifacts(artifacts: '*.log', allowEmptyArchive: true)
    }
  }
}
