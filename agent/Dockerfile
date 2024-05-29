FROM jenkins/ssh-agent:jdk21

USER root
# To get the ID of docker group and change jenkins user
COPY docker_group_guid_setter.sh /docker_group_guid_setter.sh

RUN chmod +x /docker_group_guid_setter.sh

CMD ["/docker_group_guid_setter.sh"]
