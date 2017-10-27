# To build this image, source the file

# Build user setup
docker build -t tlinnet/relax:03 -f Dockerfile_03_user_setup .
alias dr3='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax03 tlinnet/relax:03'