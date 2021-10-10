# Node.js version 13.12, npm version 6.14.4
FROM node:13.12.0-alpine
# set working directory, we're inside this dir in Docker image
WORKDIR /mytrial-fe

# mytrial-fe is the name of our app
ENV PATH /mytrial-fe/node_modules/.bin:$PATH

# install mytrial-fe dependencies, add json files to working dir
COPY package.json ./
COPY package-lock.json ./
RUN npm install
RUN npm install react-scripts -g

# add contents of mytrial-fe app to working dir
COPY . ./

# start mytrial-fe
CMD ["npm", "start"]
