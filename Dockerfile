FROM node:8

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
COPY yarn.lock /usr/src/app/
ADD entrypoint.sh /entrypoint.sh
RUN yarn

# Bundle app source
COPY . /usr/src/app

RUN yarn build

EXPOSE 8080
CMD [ "yarn", "start" ]
