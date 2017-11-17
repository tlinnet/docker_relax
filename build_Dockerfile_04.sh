# To build this image, source the file

# Build with NMRPipe and MddNMR
docker build -t $USER/relax:04_NMRPipe_MddNMR -f Dockerfile_04_NMRPipe_MddNMR .
alias dr4='docker run -ti --rm -p 8888:8888 -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/jovyan/work --name relax04 $USER/relax:04_NMRPipe_MddNMR'
