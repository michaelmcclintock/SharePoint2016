node {
    stage 'Checkout'
        // Get some code from a GitHub repository
        git url: 'https://github.com/michaelmcclintock/SharePoint2016.git' 
        
        dir('terraform') {
          git url: 'https://github.com/michaelmcclintock/terraform.git'
        }
	def yourUserName = build.causes[0].userId
	office365ConnectorSend message:"${yourUserName} has started the SharePoint 2016 Jenkins Build', status:'Checkout', webhookUrl:'https://outlook.office.com/webhook/6e869d75-dd30-45e4-a934-4676087bdb09@6f3b62d5-d8c8-4e11-affa-28d99dfcceb9/JenkinsCI/d84a85931c3342e785dc76eb160777e0/cc9f5259-d8de-4963-ae2d-1e843b2d4baf'
    stage 'Check Version'
        def tfHome = tool name: 'Terraform', type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
	def tfPlan = ""
        env.PATH = "${tfHome}:${env.PATH}"
  
        // Mark the code build 'plan'....
        stage name: 'Version'
            // Output Terraform version
            sh "terraform --version"
                
        stage 'Plan'
            if (fileExists(".terraform/terraform.tfstate")) {
               sh "rm -rf .terraform/terraform.tfstate"
            }
            if (fileExists("status")) {
               sh "rm status"
            }
    
            withCredentials([
	[
		$class: 'AmazonWebServicesCredentialsBinding',
		credentialsId: '1cb60356-7abd-42c9-bf7b-b55edbd54d09',
		accessKeyVariable: 'AWS_ACCESS_KEY_ID',
		secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
	]
]) { 
            //withCredentials([string(credentialsId: 'c8178bdb-a72f-4ede-91d3-190d6a11af15', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'db568c29-c2e0-407b-a93b-463f604a3553', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                //Remove the terraform state file so we always start from a clean state
                //sh "terraform remote config -backend=s3 -backend-config='bucket=us-west-2a.terraform.remotestate.sb' -backend-config='key=JenkinsPlayground/terraform.tfstate' -backend-config='region=us-west-2'"
                //sh "terraform remote config -backend=local -backend-config='path=terraform.tfstate'"
                //Remove the terraform state file so we always start from a clean state
                
                sh "terraform get"

                sh "set +e; terraform plan -var 'access_key=$AWS_ACCESS_KEY_ID' -var 'secret_key=$AWS_SECRET_ACCESS_KEY' -out=plan.out;echo \$? > status"
                tfPlan = '${plan.out}';
		    
		def deploy_validation = input(
                id: 'Deploy',
		    message: "Please review the plan above and lick proceed if you are good with the changes",
                type: "boolean")
            }
    
        stage name: 'Deploy', concurrency: 1
            
             
            sh "terraform --version"
    
        stage name: 'Remove', concurrency: 1
            def remove_validation = input(
                id: 'Remove',
                message: 'Please review the resources in AWS and click continue to destroy the plan',
                type: "boolean")
             
            sh "terraform --version"
    
}
