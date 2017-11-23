# To build this image, source the file

# Build with Jupyter
docker build -t $USER/relax:07_Jupyter -f Dockerfile_07_Jupyter .
alias dr7='docker run -ti --rm -p 8888:8888 -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/jovyan/work --name relax07 $USER/relax:07_Jupyter'
