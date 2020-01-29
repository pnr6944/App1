FROM centos

RUN yum update -y && \
    yum install -y git &&\
    yum install -y wget && \
    yum install -y java-1.8.0-openjdk-devel && \
    mkdir -p /app1

RUN cd /app1
RUN wget http://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.50/bin/apache-tomcat-8.5.50.tar.gz
RUN tar -xvf apache-tomcat-8.5.50.tar.gz
RUN rm apache-tomcat-8.5.50.tar.gz

RUN mv apache-* /app1/tomcat/
RUN rm /app1/tomcat/webapps/manager/META-INF/context.xml
COPY context.xml /app1/tomcat/webapps/manager/META-INF/context.xml
RUN rm /app1/tomcat/conf/tomcat-users.xml
COPY tomcat-users.xml /app1/tomcat/conf/tomcat-users.xml
COPY Online_Shopping.war /app1/tomcat/webapps/Online_Shopping.war
WORKDIR /app1/tomcat
EXPOSE 8080

CMD ["/app1/tomcat/bin/catalina.sh", "run"]
