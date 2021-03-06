# To build this image, source the file

# Build with bruker CompassXport
docker build -t $USER/relax:07_bruker_CompassXport -f Dockerfile_07_bruker_CompassXport .
alias dr7='docker run -ti --rm -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work --name relax07 $USER/relax:07_bruker_CompassXport'
