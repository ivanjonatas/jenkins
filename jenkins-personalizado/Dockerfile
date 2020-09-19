FROM jenkins/jenkins
USER root
RUN mkdir /srv/backup && chown jenkins:jenkins /srv/backup
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
COPY --chown=jenkins:jenkins job/job /var/jenkins_home