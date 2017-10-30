# To build this image, source the file

# Build relax
docker build -t $USER/relax:10 -f Dockerfile_10_relax .
alias dr10='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work --name relax10 $USER/relax:10'
