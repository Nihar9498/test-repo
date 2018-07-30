# Version for jenkins
# Update center for jenkins
# Versions for tomcat
# Tomcat home
FROM fedora
RUN yum -y install tomcat7
RUN echo "JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk" >> /etc/default/tomcat7

# Expose the default tomcat port
EXPOSE 8081

# Start the tomcat (and leave it hanging)
CMD service tomcat7 start && tail -f /var/lib/tomcat7/logs/catalina.out
