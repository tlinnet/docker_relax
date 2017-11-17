# To build this image, source the file

# Build base image with packages
source build_Dockerfile_01.sh

# Build with python
source build_Dockerfile_02.sh

# Build user setup
source build_Dockerfile_03.sh

# Build with NMRPipe and MddNMR
source  build_Dockerfile_04.sh

# Build base image with packages and relaxwith Palmer, Sparky, Analysis
source  build_Dockerfile_05.sh

## Build with mmass
source  build_Dockerfile_06.sh

## Build relax
source  build_Dockerfile_10.sh

## Build ending image updating relax
docker build -t $USER/relax  .
## Docker relax run
alias dr='docker run -ti --rm -p 8888:8888 -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/jovyan/work --name relax $USER/relax'
## Execute in Docker relax when running
alias dre='docker exec -it relax'

# See images
docker images "$USER/relax" | grep -v "none"
