FROM ubuntu:22.04 
RUN apt update && apt install -y openjdk-11-jdk maven 
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.120/bin/apache-tomcat-9.0.120.tar.gz /opt/
WORKDIR /opt 
COPY . /opt
RUN tar -xzf /opt/apache-tomcat-9.0.120.tar.gz -C /opt/ && \
    mvn clean package && \
    rm -rf /opt/apache-tomcat-9.0.120.tar.gz && \
    cp -rf /opt/target/*.war /opt/apache-tomcat-9.0.120/webapps/student.war && \
    cp -rf /opt/mysql-connector.jar /opt/apache-tomcat-9.0.120/lib/mysql-connector.jar && \
    cp /opt/context.xml /opt/apache-tomcat-9.0.120/conf/context.xml && \
    chmod +x /opt/apache-tomcat-9.0.120/bin/catalina.sh
EXPOSE 8080
CMD ["/opt/apache-tomcat-9.0.120/bin/catalina.sh","run"]
