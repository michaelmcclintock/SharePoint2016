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
                

    
        stage name: 'Ansbile', concurrency: 1
            sh "ansible --version"
}
