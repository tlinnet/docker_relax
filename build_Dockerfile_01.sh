# To build this image, source the file

# Build base image with packages
docker build -t tlinnet/relax:01 -f Dockerfile_01_packages .
ID=$(docker run -d tlinnet/relax:01 /bin/bash)
docker export $ID | docker import - tlinnet/relax:01
alias dr1='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax01 tlinnet/relax:01'
