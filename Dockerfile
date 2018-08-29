FROM tomcat:latest
RUN rm -rf /usr/local/tomcat/webapps/*
copy  target/sso.web.war  /usr/local/tomcat/webapps

