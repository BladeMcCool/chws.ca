# Use the Nginx image from Docker Hub as the base image
FROM nginx:alpine

# Remove the default Nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy the static website files into the container
COPY web /usr/share/nginx/html