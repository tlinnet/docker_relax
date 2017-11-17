# To build this image, source the file

# Build with mmass
docker build -t $USER/relax:06_mmass -f Dockerfile_06_mmass .
alias dr6='docker run -ti --rm -p 8888:8888 -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/jovyan/work --name relax06 $USER/relax:06_mmass'
