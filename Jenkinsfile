node {
    stage 'Checkout'
        // Get some code from a GitHub repository
        git url: 'https://github.com/michaelmcclintock/SharePoint2016.git' 
        
        dir('terraform') {
          git url: 'https://github.com/michaelmcclintock/terraform.git'
        }
    stage 'Check Version'
        def tfHome = tool name: 'Terraform', type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
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
    
            withCredentials([string(credentialsId: 'c8178bdb-a72f-4ede-91d3-190d6a11af15', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'db568c29-c2e0-407b-a93b-463f604a3553', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                //Remove the terraform state file so we always start from a clean state
                //sh "terraform remote config -backend=s3 -backend-config='bucket=us-west-2a.terraform.remotestate.sb' -backend-config='key=JenkinsPlayground/terraform.tfstate' -backend-config='region=us-west-2'"
                //sh "terraform remote config -backend=local -backend-config='path=terraform.tfstate'"
                //Remove the terraform state file so we always start from a clean state
                
                sh "terraform get"

                sh "set +e; terraform plan -var 'access_key=$AWS_ACCESS_KEY_ID' -var 'secret_key=$AWS_SECRET_ACCESS_KEY' --out plan"
                
            }
    
        stage name: 'Deploy', concurrency: 1
            def deploy_validation = input(
                id: 'Deploy',
                message: 'Let\'s continue the deploy plan',
                type: "boolean")
             
            sh "terraform --version"
    
        stage name: 'Remove', concurrency: 1
            def remove_validation = input(
                id: 'Remove',
                message: 'Please review the resources in AWS and click continue to destroy the plan',
                type: "boolean")
             
            sh "terraform --version"
    
}
