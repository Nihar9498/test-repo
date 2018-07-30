# Version for jenkins
# Update center for jenkins
# Versions for tomcat
# Tomcat home
ENV JENKINS_UC=https://updates.jenkins-ci.org \
	TOMCAT_MAJOR_VERSION=7 \
	TOMCAT_MINOR_VERSION=7.0.55 \
	CATALINA_HOME=/tomcat \
        JAVA_HOME='/usr/lib/jvm/jre-1.8.0-openjdk'


RUN yum install -y git 
RUN yum install -y wget 
RUN yum install -y curl 
RUN yum install -y python-lxml
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz
RUN wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - 
RUN curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | python2.7 
RUN pip install pyyaml 
RUN tar zxf apache-tomcat-*.tar.gz 
RUN rm apache-tomcat-*.tar.gz 
RUN mv apache-tomcat* tomcat 
RUN rm -rf /tomcat/webapps/* 
RUN curl -L http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -o /tomcat/webapps/ROOT.war
RUN mkdir /tomcat/webapps/ROOT && cd /tomcat/webapps/ROOT && jar -xvf '/tomcat/webapps/ROOT.war' && cd / 
RUN rm -rf /var/lib/apt/lists/* 
RUN mkdir -p /tomcat/webapps/ROOT/ref/init.groovy.d 
RUN mkdir -p /var/log/nginx/jenkins/

# Add script for running Tomcat
ADD run-tomcat.sh /run.sh

