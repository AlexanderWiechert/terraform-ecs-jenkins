FROM jenkins/jenkins:lts

# Skip initial setup
ARG JAVA_OPTS
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"

# Install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

# Provide inital Jenkins setup
COPY jenkins.yaml /usr/share/jenkins/ref/jenkins.yaml

# modify script securtiy for SeedJob
ENV JENKINS_HOME "/var/jenkins_home"
RUN mkdir $JENKINS_HOME/init.groovy.d/
COPY security.groovy $JENKINS_HOME/init.groovy.d/security.groovy

# install packages & cleanup
USER root
RUN echo 'deb http://ftp.debian.org/debian stretch-backports main' | tee /etc/apt/sources.list.d/stretch-backports.list && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-get update && \
    apt-get -y install wget python3 openjdk-11-jdk apt-transport-https ca-certificates gnupg-agent software-properties-common --no-install-recommends && \
    add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable" && \
    apt-get update && \
    apt-get -y install docker-ce docker-ce-cli containerd.io  --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
#start docker and allow jenkins to run docker
    service docker start && \
    # ls -la /var/run/docker.sock || \
    # chown jenkins:docker /var/run/docker.sock && \
# install terraform & cleanup
    wget https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_linux_amd64.zip && \
    unzip terraform_0.12.28_linux_amd64.zip -d /usr/bin && \
    rm -rf terraform_0.12.28_linux_amd64.zip && \
# install gradle & cleanup
    wget https://services.gradle.org/distributions/gradle-6.4.1-bin.zip && \
    unzip gradle-6.4.1-bin.zip  -d /opt/ && \
    rm -rf gradle-6.4.1-bin.zip && \
# cleanup tmp packages
    apt-get -y purge wget python3
# update java path & gradle path
ENV PATH="/usr/lib/jvm/java-11-openjdk-amd64/bin:/opt/gradle-6.4.1/bin:${PATH}"
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

install aws cli
 RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
     python3 get-pip.py && \
     pip install --no-cache-dir awscli && \
     rm get-pip.py



# become unprivileged user again
USER jenkins
