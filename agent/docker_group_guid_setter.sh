#!/usr/bin/env bash

# Get GID of /var/run/docker.sock
GID=$(stat -c %g /var/run/docker.sock)

# Add docker group with specific GID
groupadd -g $GID docker

# Add user jenkins to the group
usermod -a -G docker jenkins

# Eventually, launch the original jenkins/ssh-agent entrypoint
setup-sshd
