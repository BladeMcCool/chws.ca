my personal website. doesnt do too much. hosts a CV and some japanese stuff.

intention with the current setup is to have the whole thing in a Docker image, including the cv which lives in another project.

see docker-image.yml github workflow for a good example image build. tldr:  

want to build locally?

`docker build . -t website:latest --build-arg PAT=$PAT_FOR_CV_REPO_READ --no-cache`

then run it locally on port 80?

`docker run -d -p 80:80 website:latest`

not sure i want to keep it like this though. probably cv image should built independently in that project and then in this project pipeline build we just copy files out of that image
then this one would just grab that image and pull some files from it, not building that project ourself