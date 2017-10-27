# To build this image, source the file

# Build relax
docker build -t tlinnet/relax:10 -f Dockerfile_10_relax .
ID=$(docker run -d tlinnet/relax:10 /bin/bash)
docker export $ID | docker import - tlinnet/relax:10
alias dr10='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax10 tlinnet/relax:10'
