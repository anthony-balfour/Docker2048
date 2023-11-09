# FROM grabs base image from Docker
FROM ubuntu:22.04

# update all the packages on the Ubuntu machine
RUN apt-get update
#nginx is a server that will host the game on a browser
RUN apt-get install -y nginx zip curl

#configuration for nginx
RUN echo "daemon off;" >>/etc/nginx/nginx.conf
# grabs files from github
RUN curl -o /var/www/html/master.zip -L https://codeload.github.com/gabrielecirulli/2048/zip/master
#copy all files to current directory
RUN cd /var/www/html/ && unzip master.zip && mv 2048-master/* . && rm -rf 2048-master master.zip

#expose specifies the port

EXPOSE 80

# run command to start nginex and the game

CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]