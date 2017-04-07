node {
    stage 'Checkout'
        // Get base code to run
        git url: 'https://github.com/michaelmcclintock/SharePoint2016.git' 
        

    stage 'Check Version'
        // Load the Terraform tool
	def tfHome = tool name: 'Terraform 8.8', type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
	def tfPlan = ""
        env.PATH = "${tfHome}:${env.PATH}"
  
        // Mark the code build 'plan'....
        stage name: 'Version'
            // Output Terraform version
            sh "terraform --version"

	stage name: 'Plan'
            // Output Terraform version
            sh "terraform get"
	    sh "terraform plan"
	
	stage name: 'Apply'
            // Output Terraform version
            sh "terraform apply"
	    
	stage name: 'Destroy'
		sh "terraform destroy"
}
