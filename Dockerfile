# Use an official NodeJS runtime as a parent image
# Alpine for reduced image size vs. npm install needed for onbuild
FROM node:6.11.1-alpine

# Create and set the working directory
RUN mkdir -p /public
WORKDIR /public

# Copy the current directory contents into the container 
COPY . /public

# Define environment variable
ENV PORT=1337
ENV MONGODB_URI=mongo

# Install any needed packages with yarn (should be bundled with official node image)
RUN apk upgrade --update && \
    apk add --no-cache bash git openssh && \
    yarn && \
    yarn global add grunt-cli knex && \
    yarn cache clean

# Run when the container launches
CMD ["yarn", "start-ana"]

# Make port 3030 available to the world outside this container
EXPOSE 1337 27017