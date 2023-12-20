# FROM grabs base image from Docker
FROM ubuntu:22.04

# update all the packages on the Ubuntu machine
RUN apt-get update

#nginx is a server that will host the game on a browser
# inistalls the utility packages zip and curl
RUN apt-get install -y nginx zip curl

#configuration for nginx.
# daemon is a process that runs in the background
# runs Nginx runs in the foreground, allowing it to be managed by Docker effectively
# Docker expects and works with files running in the foreground, not in the background processes
# command to not run as background daemon
# appends the daemon off line to the listed file
RUN echo "daemon off;" >>/etc/nginx/nginx.conf

# grabs files from github and saves in the/var/www/html/ directory
#-o is output file path and name
#-L follows url redirects
RUN curl -o /var/www/html/master.zip -L https://codeload.github.com/gabrielecirulli/2048/zip/master


#copy all files to current dictory and removes the master/master.zip files
#mv is move
#rm is remove
#-rf is recursive so all subdirectories and forced (without prompting for confirmation)
RUN cd /var/www/html/ && unzip master.zip && mv 2048-master/* . && rm -rf 2048-master master.zip

#expose specifies the port
#Runs on port 8003 on EC2 instance CRUDFullStack
EXPOSE 80

# run command to start nginx and the game

CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]