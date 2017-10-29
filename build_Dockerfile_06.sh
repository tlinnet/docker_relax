# To build this image, source the file

# Build with mmass
docker build -t tlinnet/relax:06 -f Dockerfile_06_mmass .
alias dr6='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work --name relax06 tlinnet/relax:06'
