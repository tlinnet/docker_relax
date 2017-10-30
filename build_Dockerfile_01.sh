# To build this image, source the file

# Build base image with packages
docker build -t $USER/relax:01_packages -f Dockerfile_01_packages .
alias dr1='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work --name relax01 $USER/relax:01_packages'
