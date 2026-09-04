@Library('pipeline-library') _

String dataCenter = 'ms7'
String backupDbOperBackupDirectory = "\\\\${dataCenter}-def-fs01\\DFS-MS-SQLOperBackup-${dataCenter}\\"

Map config = readYaml(text: """
properties:
  parameters:
  - name: SiteName
    type: string
    description: 'Name of the site whose database will be migrated.'
  - name: PostgreSQLServerTarget
    type: string
    description: 'Target PostgreSQL server to migrate the database to.'
  - name: PostgreSQLServerPortTarget
    type: string
    description: 'Port of the target PostgreSQL server to migrate the database to.'
    defaultValue: "5432"
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

	Map args = [
      Site: SiteName,
      PostgreSQLServerTarget: PostgreSQLServerTarget,
      BackupDbOperBackupDirectory: backupDbOperBackupDirectory,
      PostgreSQLServerPortTarget: PostgreSQLServerPortTarget,
	DataCenter: dataCenter
	]

	powershellExecute(
		isStage: true,
		name: "Move PostgreSQL DB",
		file: 'PowerShell/Jenkins/metarunner_move_pg_db.ps1',
		args: args)
}
