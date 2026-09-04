@Library('pipeline-library') _

String dataCenter = 'ms6'

Map config = readYaml(text: """
general:
  projectName: "Extract postgresql backup"
properties:
  parameters:
  - name: PGHost
    type: string
    description: "PostgreSQL host where is database, e.g. 'ms6-x-pg01'"
    defaultValue: "ms6-test-pg01"
  - name: DatabaseName
    type: string
    defaultValue: "bpmonline7182studio"
  - name: RestoreType
    type: choice
    choices: ["default", "time", "name"]
    description: "default - recover to the end of the archive stream (leave 'Target' empty).\\ntime - recover to the time specified in 'Target'.\\nname - recover the restore point specified in 'Target' (20210727-072736F or 2001-09-30 8:46:26)"
  - name: Target
    type: string
kubernetes:
  cloud: $dataCenter
  namespace: $dataCenter-jenkins
  workspaceVolumeInMemory: true
  containers:
  - containerName: pgbackrest
    image: bpmonline/pgbackrest-restore-worker:$PG_BACKREST_VERSION
    skipCommand: true
  envVars:
  - key: POSTGRES_PASSWORD
    value: ${UUID.randomUUID()}
  volumes:
  - type: emptyDirVolume
    mountPath: /var/lib/postgresql/data
  - type: nfsVolume
    serverAddress: ms6-def-fs01
    serverPath: /NFS/PostgreSQL-Backup
    mountPath: /backups
    readOnly: false
""")

zPipeline(config) {
  if (!params.PGHost || !params.DatabaseName || !params.RestoreType) {
    throw new Exception("The parameters 'PGHost', 'DatabaseName' and 'RestoreType' must be provided.")
  }

  container('pgbackrest') {
    try {
      powershellExecute(
        isStage: true,
        name: 'Extract database backup',
        file: 'PowerShell/Jenkins/metarunner_extract_pgdump_from_pgbackrest_store.ps1',
        args: [
          DataCenter: dataCenter,
          DatabaseHost: params.PGHost,
          DatabaseName: params.DatabaseName,
          Type: params.RestoreType,
          Target: params.Target,
          BackupDirectory: '/backups',
          LogDirectory: WORKSPACE
        ]
      )
    } finally {
      sh "find ${WORKSPACE} -maxdepth 1 -name '*.log' -exec chmod 755 {} \\;"
      archiveArtifacts(artifacts: '*.log', allowEmptyArchive: true)
    }
  }
}