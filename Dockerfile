# First stage: Clone repo and build project
FROM node:alpine as builder
ARG PAT

# Install git
RUN apk add --no-cache git

WORKDIR /app
# copy our main simplistic website files into a web dir here in /app
COPY web web

# clone my super duper cool resume thinger that i made
RUN git clone https://$PAT:x-oauth-basic@github.com/BladeMcCool/ReactResume.git
#set this to whatever ref you like for now.
RUN cd ReactResume && git checkout 2024-03-update
# build the resume
RUN cd ReactResume && npm install && npm run build
# move the built files into resume dir of web
RUN mv ReactResume/build web/resume
RUN pwd
RUN ls -l


# Second stage: Setup runtime container
# Use the Nginx image from Docker Hub as the base image
FROM nginx:alpine

# Remove the default Nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy the static website files, including the build resume files, into the container - it places the contents of the 'web' dir, from the builder stage from this Dockerfile, directly into the nginx 'html' dir
COPY --from=builder /app/web /usr/share/nginx/html
