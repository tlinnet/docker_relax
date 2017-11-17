# To build this image, source the file

# Build relax
docker build -t $USER/relax:10_relax -f Dockerfile_10_relax .
alias dr10='docker run -ti --rm -p 8888:8888 -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/jovyan/work --name relax10 $USER/relax:10_relax'
