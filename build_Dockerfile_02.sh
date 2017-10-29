# To build this image, source the file

# Build with python
docker build -t tlinnet/relax:02 -f Dockerfile_02_python .
alias dr2="docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v '$PWD':/home/developer/work --name relax02 tlinnet/relax:02"
