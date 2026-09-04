@Library('pipeline-library') _

String dataCenter = 'ms2'

Map config = readYaml(text: """
properties:
  parameters:
  - name: SourceSiteName
    type: string
    description: 'Исходное имя бакета. Нужно для идентификации имени исходных бакетов.'
  - name: TargetBucketName
    type: string
    description: 'Целевое имя бакета. Нужно для идентификации имени целевых бакетов.'
  - name: Region
    type: string
    description: 'Регион в который будет скопированы целевые бакеты.'
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
        TargetBucketName: targetBucketName,
        Region: region,
        SMTPServer: "smtp.bpmonline.com",
        SMTPPort: "25",
        SMTPFrom: "aws-notify@bpmonline.com",
        UserID: userID,
        BuildURL: BUILD_URL
		]
		
    powershellExecute(
      isStage: true,
      name: "Copy S3 Bucket",
      file: 'PowerShell/TeamCity/metarunner_copy_s3_buckets.ps1',
      args: args)
    
      
    archiveArtifacts(artifacts: 'ConnectionString.txt', allowEmptyArchive: true)
    }
}

