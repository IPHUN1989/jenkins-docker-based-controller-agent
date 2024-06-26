FROM jenkins/jenkins:jdk21

# Switch to root user to install packages
USER root

# Update the package list, install necessary packages, and clean up
RUN apt-get update && \
    apt-get -y install apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# Set the Jenkins reference directory
ENV JENKINS_REF /usr/share/jenkins/ref

# Set the Jenkins home directory
ENV JENKINS_HOME /var/jenkins_home/

# Skip the initial password setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Copy the plugins.txt file to the Jenkins reference directory
COPY ./plugins.txt $JENKINS_REF/

# Install plugins using the jenkins-plugin-cli
RUN jenkins-plugin-cli --plugin-file "$JENKINS_REF"/plugins.txt --latest true

# Copy the contents of the settings folder to the Jenkins home directory
COPY ./settings/. /$JENKINS_HOME/

# Chnage permissions to the $JENKINS_HOME folder recursively
RUN chown -R jenkins:jenkins /$JENKINS_HOME/

# Create the docker group and add Jenkins user to it
RUN groupadd docker && usermod -a -G docker jenkins

# Switch back to Jenkins user
USER jenkins

# Create the plugins directory in the Jenkins reference directory
RUN mkdir -p "$JENKINS_REF"/plugins