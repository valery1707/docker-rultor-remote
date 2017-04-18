#FROM ruby:2.2-alpine
FROM ubuntu:14.04
 
ENV DEBIAN_FRONTEND=noninteractive
 
# Update
RUN apt-get update && apt-get upgrade -y -V
 
# PPA
RUN apt-get install -y software-properties-common python-software-properties
 
# Dependency
#RUN apk add --no-cache gpgme
#RUN apk add --no-cache bcrypt
RUN apt-get install pgp
RUN apt-get install bcrypt
 
# Ruby
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update && apt-get install -y ruby2.2
#RUN apt-get install ruby2.2
 
# Rultor-remote
RUN gem install rultor
CMD ["rultor", "--help]
