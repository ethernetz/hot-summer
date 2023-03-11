FROM ethernetz/docker-firebase-tools:latest

# Create and define the functions' node_modules cache directory
WORKDIR /home/node/functions-cache

# Install functions' node_modules into the functions-cache directory
COPY --chown=node:node ./functions/package.json ./functions/package-lock.json* ./
RUN npm install

# Create and define the application's working directory
WORKDIR /home/node/app

# Add functions' node_modules to path so we can run packages
ENV PATH /home/node/app/functions/node_modules/.bin:$PATH
