node {
  //switch to gitlab source code branch
  stage('SCM') {
    checkout scm
    echo "Current branch: ${env.BRANCH_NAME}"
  }
  //Developer Test Cases to be used
  stage('Test') {
    echo "Testing"
  }
  //Scan code for vulnerabilities and quality
  stage('Scan') {
    def scannerHome = tool 'sonarqube';
    withSonarQubeEnv() {
      sh "${scannerHome}/bin/sonar-scanner"
    }
  }
  //Build and copy code into image
  stage('Build') {
    def dockerHome = tool 'myDocker'
      env.PATH = "${dockerHome}/bin:${env.PATH}"
      echo "success if plugin found"
    
    def customImage = docker.build("webapp-prod:${env.BUILD_ID}")
  
    // Tag the image for local docker registry
            sh "docker tag webapp-prod:${env.BUILD_ID} 10.11.7.7:5000/webapp-prod:${env.BUILD_ID}"
            
    // Push the image to docker registry
            sh "docker push 10.11.7.7:5000/webapp-prod:${env.BUILD_ID}"
          
  }
  //testing 
  stage('Stage') {
        echo "Reviewing changes on Staging area"
     // Push image to staging server first
      script{

        def HOSTIP = 'stagingserver'           // Docker Host (Host 2)
        def CONTAINERPORT = '80'               
        def IMAGE= 'webimg'
       
      // Connect via ssh-agent from Jenkins
        sshagent(['sshpkey-apphost-id']){
        sh """
        ssh  -o StrictHostKeyChecking=no bee@${HOSTIP} '
        docker pull 10.11.7.7:5000/webapp-prod:${env.BUILD_ID}

        if [ \$(docker ps -q -f name=mywebapp) ]; then
        
        docker stop mywebapp && docker rm mywebapp
          
        fi '

        ssh  -o StrictHostKeyChecking=no bee@${HOSTIP} '
        docker run -d --name mywebapp -p 10.11.7.8:8080:80 10.11.7.7:5000/webapp-prod:${env.BUILD_ID}'

      
            """
        }
            
    }
      
    
  }
// Approval Stage
stage('Approval') {

//waiting on input
     echo "Waiting for approval from developer after testing in Staging..."
     input message: 'Proceed to production deployment?', ok: 'Deploy'

  }
  
//Deployment stage
stage('Deploy') {

  //Push final verified image with code to production server
  
    script{
      def HOSTIP = 'webservices'           // Docker Host (Host 1)
      def CONTAINERPORT = '80'               
      def IMAGE= 'webimg'
       
      // Use the ssh-agent plugin to provide the SSH key
      sshagent(['sshpkey-apphost-id']) {
        sh """
        ssh  -o StrictHostKeyChecking=no bee@${HOSTIP} '
        docker pull 10.11.7.7:5000/webapp-prod:${env.BUILD_ID}

        if [ \$(docker ps -q -f name=mywebapp) ]; then
        
        docker stop mywebapp && docker rm mywebapp
          
        fi '

        ssh  -o StrictHostKeyChecking=no bee@${HOSTIP} '
        docker run -d --name mywebapp -p 10.11.7.5:8080:80 10.11.7.7:5000/webapp-prod:${env.BUILD_ID}'

      
            """
            }
    }
      echo "Staging deployment successful. Developer must now test the application."   
    
  
}
//Remove unused or tagged images
stage('Cleanup') {
  
        script {
            echo "Cleaning up unused Docker images and containers"
            sh 'docker image prune -f'        
        }
    }

}