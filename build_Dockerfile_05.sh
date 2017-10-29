# To build this image, source the file

# Build base image with packages and relaxwith Palmer, Sparky, Analysis and PyMOL
docker build -t tlinnet/relax:05 -f Dockerfile_05_Palmer_Sparky_Analysis_PyMOL .
alias dr5='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work --name relax05 tlinnet/relax:05'
