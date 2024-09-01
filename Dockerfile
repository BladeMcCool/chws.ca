# First stage: Obtain the built project files from a pre-built image
ARG RESUME_REF=master
FROM ghcr.io/blademccool/resume:${RESUME_REF} as builder

# Second stage: Setup runtime container
# Use the Nginx image from Docker Hub as the base image
FROM nginx:alpine

# Set the working directory to where Nginx serves files
WORKDIR /usr/share/nginx/html

# Remove the default Nginx static assets
RUN rm -rf ./*

# Copy main static website files from local filesystem
COPY web .

# Copy the built resume files into the container - it places the contents of the '/app/build' dir, from the builder stage from this Dockerfile, directly into the nginx 'html/resume' dir
COPY --from=builder /app/build /usr/share/nginx/html/resume

# Copy any files from the replaceinbuild directory (like the _actual_ resumedata.json during the Github Action image build prior to publishing the real website live) that exist
COPY replaceinbuild/* /usr/share/nginx/html/resume/