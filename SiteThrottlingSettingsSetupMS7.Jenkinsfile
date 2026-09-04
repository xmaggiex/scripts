@Library('pipeline-library') _

String dataCenter = 'ms7'

Map config = readYaml(text: """
properties:
  parameters:
  - name: SiteName
    type: string
    description: 'Имя сайта. Нужно для идентификации.'
  - name: LimitAction
    type: string
    description: 'Действие при достижении лимита. Может быть: KillW3wp, Throttle, ThrottleUnderLoad, NoAction.'
  - name: LimitPercent
    type: string
    description: 'Значение лимита в процентах. От 0 до 100.'
  - name: MemoryLimit
    type: string
    description: 'Значение лимита объема памяти.'
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
        SiteName: SiteName,
        LimitPercent: LimitPercent,
        LimitAction: LimitAction,
	MemoryLimit: MemoryLimit
		]
		
    powershellExecute(
      isStage: true,
      name: "Set AppPool Throttlng Level",
      file: 'PowerShell/Set-ApplicationPoolCPUAndMemoryThrottlingValue.ps1',
      args: args)
    
    }
}