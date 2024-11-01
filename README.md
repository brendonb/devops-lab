# devops-lab
Devops Lab demo in Oracle virtual box

<img src="https://i.imgur.com/Fvr1W1b.jpg" title="source: imgur.com" />
<h1>DevOps Engineering and CI/CD</h1>


<h2>Description</h2>
This is my first Devops project after completing DevOps Kodekloud course.
The main aim of this project was to practice and implement a CICD pipeline while getting firmiliar with DevOps Engineering tools,
and gradually migrate from a private lab to a Cloud provider.
<br />


<h2> Applications and Utilities Used</h2>

- <b>Visual Studio Code Editor</b> 
- <b>Html and Css</b>
- <b>Ubuntu Linux Server 24.04</b>
- <b>Apache Web Server</b>
- <b>Nginx Web Server for Reverse Proxying</b>
- <b>Docker</b>
- <b>Jenkins</b>
- <b>Gitlab CE</b>
- <b>Sonarqube</b>
- <b>Prometheus</b>
- <b>Grafana</b>
  


<h2>Program walk-through:</h2>

<p align="center">
Sample snippets: <br/>
<img src="https://i.imgur.com/rGVFHbY.png" height="80%" width="80%" />
  <h1> Gitlab</h1>
<img src="https://i.imgur.com/tvllt7m.png" height="80%" width="80%" />
  <h1>SonarQube</h1>
<img src="https://i.imgur.com/xZLTbio.png" height="80%" width="80%" />
  <h1>Prometheus</h1>
<img src="https://i.imgur.com/5cOHD7C.png" height="80%" width="80%" />
  <h1>Grafana</h1>
<img src="https://i.imgur.com/jDtqEK2.png" height="80%" width="80%" />
  <h1>CICD Pipeline </h1>
<img src="https://i.imgur.com/I4VmkZg.png" height="80%" width="80%" />
  <h1>Demo Website</h1>
<img src="https://i.imgur.com/MFXPVwS.png" height="80%" width="80%" />
</p>

- <h3>Virtual Box Setup</h3>
  For the networking setup i used Natnetwork and a Bridge network setup this allows the host to have access to vm's and the vm's internet access,
  In order to implement a modular network architecture and separate the services on different subnets.<br>
  The 3 Vm's are running on Ubuntu Linux and has atmost 8gb Ram with 25GB Hdd's or vitual disks each with a minimu of 2 to 3 cpu's.
- <h3>Challenges</h3>
  The first challenge i faced was in Gitlab getting the webhook connected, this is a common issue if you are using Gitlab in local
  virtual environment , getting the webhook to send events to Jenkins, the solution was to set the Outbound request to allow connection locally,
  even though this could be a potential risk , for the sake of the demo it solved the problem.<br>
  The second challenge i faced within my Jenkinsfile pipeline, so the idea was to allow merge request to be deployed only to the staging server,
  where the identical copy of the site was running before it went to production, like to how to accomplish this, after some struggle and research
  i implement an Approval stage where the pipeline waits for manual approval after succesfull merge in gitlab, once done the Deployment stage continued.
  
- <h3>CICD Workflow</h3>
<img src="https://i.imgur.com/oAJJrRZ.png" />
The CI/CD pipeline process starts when the developer has pushed code the staging branch from here a merge request is created for the main branch , however
the code must be reviewed first and the request is assigned to a Quality Assurance Officer or Senior Developer , once approved the code is merged into the main git 
branch and the source managed checkout stage run following the Test stage where unit tests, or integration tests or both runs, for this demo there was no test cases included.
When the test stage passed succesfully, Sonarqube runs a scan to check code quality or possible vulnerabilities, once the scan is complete docker builds a new image for httpd/apache
webserver that copies the html and css files into the container when the docker build command has been issued.<br>The image is then copied to the staging server using secret text authentication
for security and the container is created and started, now the Manual Testing can be begin for UAT( User Acceptance Testing).In the meantime the jenkins server waits for approval input or to abort 
if any new problems were found, assuming no problems the Senior Developer or Product Manager would then approve it and the container with same build image would be deployed into the
production environment.





<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
