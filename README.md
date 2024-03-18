my personal website. doesnt do too much. hosts a CV and some japanese stuff.

intention with the current setup is to have the whole thing in a Docker image, including the cv which lives in another project.

want to build locally? docker login to ghcr with a pat that can read registry as the password (it needs to obtain files from another image), then build it
see docker-image.yml github workflow for a good example image build. tldr:  

`docker login ghcr.io -u blademccool` 
`docker build . -t website:latest --no-cache`

then run it locally on port 80?

`docker run -d -p 80:80 website:latest`

updating the deployed website should just be a matter of pushing commits to master branch in this repo. our docker image build should go obtain static pre-built website subcomponents for including in the website file system, push the updated complete website image to registry, and then trigger digital ocean deploy of latest tag of the image. 