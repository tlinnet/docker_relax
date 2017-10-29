# To build this image, source the file

# Build with NMRPipe and MddNMR
docker build -t tlinnet/relax:04 -f Dockerfile_04_NMRPipe_MddNMR .
alias dr4='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work --name relax04 tlinnet/relax:04'
