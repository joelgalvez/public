# Dockerfile

# base image
FROM node:alpine

# create & set working directory
RUN mkdir -p /home/joel/src
WORKDIR /home/joel/src

# copy source files
COPY . /home/joel/src

# install dependencies
RUN npm install

# start app
RUN npm run build
EXPOSE 3000
CMD npm run start
