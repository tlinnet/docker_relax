# To build this image, source the file

# Build base image with packages and relaxwith Palmer, Sparky, Analysis and PyMOL
docker build -t $USER/relax:05_Palmer_Sparky_Analysis -f Dockerfile_05_Palmer_Sparky_Analysis .
alias dr5='docker run -ti --rm -p 8888:8888 -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/jovyan/work --name relax05 $USER/relax:05_Palmer_Sparky_Analysis'
