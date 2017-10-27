# To build this image, source the file

# Build base image with packages
docker build -t tlinnet/relax:01 -f Dockerfile_01_packages .
ID=$(docker run -d tlinnet/relax:01 /bin/bash)
docker export $ID | docker import - tlinnet/relax:01
alias dr1='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax01 tlinnet/relax:01'

# Build with python
docker build -t tlinnet/relax:02 -f Dockerfile_02_python .
ID=$(docker run -d tlinnet/relax:02 /bin/bash)
docker export $ID | docker import - tlinnet/relax:02
alias dr2='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax02 tlinnet/relax:02'

# Build user setup
docker build -t tlinnet/relax:03 -f Dockerfile_03_user_setup .
alias dr3='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax03 tlinnet/relax:03'

# Build with NMRPipe and MddNMR
docker build -t tlinnet/relax:04 -f Dockerfile_04_NMRPipe_MddNMR .
ID=$(docker run -d tlinnet/relax:04 /bin/bash)
docker export $ID | docker import - tlinnet/relax:04
alias dr4='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax04 tlinnet/relax:04'

# Build base image with packages and relaxwith Palmer, Sparky, Analysis and PyMOL
docker build -t tlinnet/relax:05 -f Dockerfile_05_Palmer_Sparky_Analysis_PyMOL .
ID=$(docker run -d tlinnet/relax:05 /bin/bash)
docker export $ID | docker import - tlinnet/relax:05
alias dr5='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax05 tlinnet/relax:05'

# Build with mmass
docker build -t tlinnet/relax:06 -f Dockerfile_06_mmass .
ID=$(docker run -d tlinnet/relax:06 /bin/bash)
docker export $ID | docker import - tlinnet/relax:06
alias dr6='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax06 tlinnet/relax:06'

# Build relax
docker build -t tlinnet/relax:10 -f Dockerfile_10_relax .
ID=$(docker run -d tlinnet/relax:10 /bin/bash)
docker export $ID | docker import - tlinnet/relax:10
alias dr10='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax10 tlinnet/relax:10'

# Build ending image updating relax
docker build -t tlinnet/relax  .
alias dr='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax tlinnet/relax'
