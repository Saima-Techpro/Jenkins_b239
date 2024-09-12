FROM jenkins/jenkins:2.430-jdk21
USER root
RUN apt-get update && apt-get install -y lsb-release wget gnupg
RUN wget -O /tmp/openjdk-21_linux-x64_bin.deb https://download.java.net/java/GA/jdk21/21/GPL/openjdk-21_linux-x64_bin.deb
RUN apt-get install -y /tmp/openjdk-21_linux-x64_bin.deb
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"

