# Jenkins CI/CD tool in a docker-based setup with controller-agent architect

![GitHub repo size](https://img.shields.io/github/repo-size/IPHUN1989/jenkins-docker-based-controller-agent)
![GitHub language count](https://img.shields.io/github/languages/count/IPHUN1989/jenkins-docker-based-controller-agent)
![Static Badge](https://img.shields.io/badge/total%20number%20of%20tracked%20files-14-blue)
![GitHub contributors](https://img.shields.io/github/contributors/IPHUN1989/jenkins-docker-based-controller-agent)
![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/t/IPHUN1989/jenkins-docker-based-controller-agent?label=total%20commits)
![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/m/IPHUN1989/jenkins-docker-based-controller-agent?label=monthly%20commits)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/IPHUN1989/jenkins-docker-based-controller-agent/main)
![GitHub closed issues](https://img.shields.io/github/issues-closed/IPHUN1989/jenkins-docker-based-controller-agent)
![GitHub issues](https://img.shields.io/github/issues-raw/IPHUN1989/jenkins-docker-based-controller-agent)
![GitHub pull requests](https://img.shields.io/github/issues-pr/IPHUN1989/jenkins-docker-based-controller-agent)


# Project scope
**The project aims to provide a docker based CI/CD pipeline server setup, where pipeline builds with docker containers are going to work out of box. Some setups are going to be already predefined by following the Step by step guide, but further customization are available for the user.**
**The project is using the following technologies:**
- <img src="https://upload.wikimedia.org/wikipedia/commons/e/e9/Jenkins_logo.svg" alt="drawing" width="30" height="30" align="center"/> *Jenkins* 
- <img src="https://raw.githubusercontent.com/yurijserrano/Github-Profile-Readme-Logos/042e36c55d4d757621dedc4f03108213fbb57ec4/cloud/docker.svg" alt="drawing" width="30" height="40" align="center"/> *Docker* 

# Prerequisites

**Download and install docker from here:**
- *<a href="https://docs.docker.com/desktop/install/linux-install/"> Linux </a>*
- *<a href="https://docs.docker.com/desktop/install/windows-install/"> Windows </a>*
- *<a href="https://docs.docker.com/desktop/install/mac-install/"> Mac </a>*


# System diagram

<img src="docs/system.svg" alt="drawing" width="400" align="center"/>
<br>
<br>

# Technology background

- **It is a Jenkins server that is capable of running docker based builds with a dedicated agent that runs alongside with it. The agent is responsible for building and it is capable to run docker commands by using your host computer's docker socket.**
- **Correct permission rights are automatically generated during the Agent docker image building phase by running a script that checks the group ID of the socket and creates a new group in the image called docker with the same GID. Then adds the jenkins user to that group.**
- **We use the jenkins user login via SSH to the agent and give docker commands to use containers dynamically during a pipeline run.**

# Step by step instructions:

0. *This image copied some existing settings therefore you already have the following default settings:* 
    - *Skipping initial setup phase*
    - *Jenkins Controller requires you to register a user in order to use it, no registered user is included*
    - *Built in node's executors are set to 0*
    - *An existing Agent is set to be the default builder and most of the settings are already included*
    - *An existing credential is set with no private SSH key included* 

1. *If you use Windows then please modify the compose.yml file to the following:*
    - *services -> jenkins_agent -> volumes -> from "/var/run/docker.sock:/var/run/docker.sock" to "//var/run/docker.sock://var/run/docker.sock" and "/usr/bin/docker:/usr/bin/docker" to //usr/bin/docker://usr/bin/docker (note the double slash)*
    - *If you use Linux or Mac, then you can proceed without extra modifications* 

2. *Generate an SSH key with pair rsa:*
    - *<a href="https://www.ssh.com/academy/ssh/keygen"> Linux </a>*
    - *<a href="https://phoenixnap.com/kb/generate-ssh-key-windows-10"> Windows </a>*
    - *<a href="https://mdl.library.utoronto.ca/technology/tutorials/generating-ssh-key-pairs-mac"> Mac </a>*

3. *Add the public key to the template_env* 

4. *Rename the template_env file in the ${local_folder_of_cloned_project} to .env*

5. *Run "docker compose up" in the root folder of the cloned project (run it with a -d flag if you don't wish to see the logs in your terminal)*

6. *Visit http://localhost:9100/*

7. *Default settings are requiring to you to register yourself, thus please click on the Sign up for Jenkins on the page and fill out the requested details (please note that while email address is a mandatory field, it doesn't require an actual email address)*

8. *After you finished the registration please click on Manage Jenkins -> Credentials -> System -> Global credentials (unrestricted) -> agent -> Update:*
    - *Private key: copy the private key you generated at the second step and paste it in by clicking on the Replace button*
    - *Passphrase: blank unless you gave a password to the SSH key*
    - *Click on Save*

9. *After you saved it, go back to Manage Jenkins -> Nodes -> Agent -> Launch Agent*

10. *After that you should see the following message in the logs as the last line: "Agent successfully connected and online". Your Jenkins system is ready to use. If you wish to try it out with the sample pipeline I provided in this project, then please follow the instructions in the "Setting up a pipeline" section.*

## Setting up a pipeline (not mandatory)

**You can you try out the system by creating a new pipeline. You may test it with the sample Jenkinsfile I provided in this repository.
- *Copy the content of the Jenkinsfile*
- *New Item*
- *Name it and choose Pipeline as an item type*
- *Paste the content of the Jenkinsfile to the Pipeline -> Script field. Then save it*
- *Then click on the Build Now button on the left side*
- *The agent should launch a container with a Node image with Docker where the Console output should return the version of the Node that is running on the container which should be: "v18.20.3"*
- *This means that the setup was successful and this Agent ready to use Docker*


# Troubleshooting:

## Known issues:

### Windows:

#### Issue:

**When you clone the project with Git it will overwrite in some files the denotes of newline characters from LF to CRLF.**


#### Hotfix:
**Please modify the Dockerfile of the agent to this:**

```Dockerfile
RUN perl -pi -e 's/\r\n|\n|\r/\n/g' /docker_group_guid_setter.sh
#RUN /docker_group_guid_setter.sh
``` 

**And your docker_group_guid_setter.sh to this:**

```sh
# Eventually, launch the original jenkins/ssh-agent entrypoint
# setup-sshd
```

**Further investigation is needed in this issue**
