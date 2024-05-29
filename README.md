# Jenkins CI/CD tool in a docker-based setup with controller-agent architect

![GitHub repo size](https://img.shields.io/github/repo-size/IPHUN1989/jenkins-docker-based-controller-agent)
![GitHub language count](https://img.shields.io/github/languages/count/IPHUN1989/jenkins-docker-based-controller-agent)
![Static Badge](https://img.shields.io/badge/total%20number%20of%20tracked%20files-10-blue)
![GitHub contributors](https://img.shields.io/github/contributors/IPHUN1989/jenkins-docker-based-controller-agent)
![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/t/IPHUN1989/jenkins-docker-based-controller-agent?label=total%20commits)
![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/m/IPHUN1989/jenkins-docker-based-controller-agent?label=monthly%20commits)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/IPHUN1989/jenkins-docker-based-controller-agent/development)
![GitHub closed issues](https://img.shields.io/github/issues-closed/IPHUN1989/jenkins-docker-based-controller-agent)
![GitHub issues](https://img.shields.io/github/issues-raw/IPHUN1989/jenkins-docker-based-controller-agent)
![GitHub pull requests](https://img.shields.io/github/issues-pr/IPHUN1989/jenkins-docker-based-controller-agent)


# Project scope
**The project aims to provide a docker based CI/CD pipeline server setup, where pipeline builds with docker containers are going to work out of box. Some setups are going to be already predefined by following the Step by step guide, but further customization are available for the user.**
**The project is using the following technologies:**
- <img src="https://upload.wikimedia.org/wikipedia/commons/e/e9/Jenkins_logo.svg" alt="drawing" width="30" height="30" align="center"/> *Jenkins* 
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/cloud/docker.svg" alt="drawing" width="30" height="40" align="center"/> *Docker* 


# System diagram

<img src="docs/system.svg" alt="drawing" width="400" align="center"/>

<br>
<br>

# Technology background
- **A Jenkins server that is capable of running docker based builds with a dedicated agent that runs alongside with it. The agent is responsible for building and it is capable to run docker commands by using your host computer's docker socket.**
- **Correct permission rights are automatically generated during the Agent docker image building phase by running a script that checks the group ID of the socket and creates a new group in the image called docker with the same GID. Then adds the jenkins user to that group.** 
- **We use the jenkins user login via SSH to the agent and give docker commands to use containers dynamically during a pipeline run.**

# Step by step instructions:

1. *Generate an SSH key*
2. *Add the public key to the template_env* 
3. *Rename the template_env file in the ${local_folder_of_cloned_project} to .env*
4. *Run "docker compose up" in the root folder of the cloned project*
5. *Get the key that loads for the first time with the Jenkins Controller by pasting the following command to your terminal: "docker exec <container_name> cat /var/jenkins_home/secrets/initialAdminPassword" then copy the results*
6. *Visit http://localhost:9100/ and finish the initial setup*
7. *Install 2 important plugins via Manage Jenkins -> Plugins -> Available plugins:* 
    - *Docker plugin*
    - *Docker Pipeline*
8.  *Login to the your Jenkins controller and go to Manage Jenkins -> Credentials -> System -> Global Credentials -> Add credential*
9. *Settings:*
    - *Kind: SSH Username with private key*
    - *Scope: Global*
    - *ID: Whatever you want to name it*
    - *Description: Give a detailed description to it*
    - *Username: jenkins*
    - *Private key: copy the private key you generated at the first step and Enter directly -> Add*
    - *Passphrase: blank unless you gave a password to the SSH key*
10. *After creating it, go back to Manage Jenkins -> Nodes -> Built-In-Node -> Configure -> Set Executors to 0*
11. *After you saved it, go back to Nodes -> New Node*
12. *Give a desired name to your agent, and select permanent agent*
13. *Fill out the followings:*
    - *Number of executors: minimum 1*
    - *Remote FS root: /home/jenkins/agent*
    - *Use: Use this node as much as possible*
    - *Running method: Launch agent via SSH*
    - *Host: jenkins-agent*
    - *Credentials: select the credentials you created at step 9*
    - *Host Key Verification Strategy: Manually trusted key Verification Strategy*
    - *Availability: Keep this agent online as much as possible*
14. *After that you can you try it out by creating a new pipeline. You may test it with the sample Jenkinsfile I provided in this repository.*
