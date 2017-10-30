# To build this image, source the file

# Build with NMRPipe and MddNMR
docker build -t $USER/relax:04_NMRPipe_MddNMR -f Dockerfile_04_NMRPipe_MddNMR .
alias dr4='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work --name relax04 $USER/relax:04_NMRPipe_MddNMR'
