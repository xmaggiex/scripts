@Library('pipeline-library') _

String dataCenter = 'ms2'

Map config = readYaml(text: """
properties:
  parameters:
  - name: SourceSiteName
    type: string
    description: 'Исходное имя папки. Нужно для идентификации имени исходных папок.'
  - name: TargetFolderName
    type: string
    description: 'Целевое имя папки. Нужно для идентификации имени целевых папок.'
  - name: TargetSiteUserbucket
    type: string
    description: 'Userbucket в который будут скопированы целевые папки. Пример ms1-userbucket'
  enableGitLabConnection: false
  disableConcurrentBuilds: true
general:
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

    def cause = currentBuild.getBuildCauses('hudson.model.Cause$UserIdCause')
    def userID = cause.userId

		Map args = [
        SourceSiteName: sourceSiteName,
        TargetFolderName: targetFolderName,
        TargetSiteUserbucket: targetSiteUserbucket,
        SMTPServer: "smtp.bpmonline.com",
        SMTPPort: "25",
        SMTPFrom: "aws-notify@bpmonline.com",
        UserID: userID,
        BuildURL: BUILD_URL
		]
		
    powershellExecute(
      isStage: true,
      name: "Copy S3 Bucket",
      file: 'PowerShell/TeamCity/metarunner_copy_s3_folders.ps1',
      args: args)
    
      
    archiveArtifacts(artifacts: 'ConnectionString.txt', allowEmptyArchive: true)
    }
}

