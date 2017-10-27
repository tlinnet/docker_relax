# To build this image, source the file


# Build base image with packages and relax
docker build -t tlinnet/relax:01 -f Dockerfile_01_packages .
alias dr1='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax01 tlinnet/relax:01'

# Build with python
docker build -t tlinnet/relax:02 -f Dockerfile_02_python .
alias dr2='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax02 tlinnet/relax:02'

# Build user setup
docker build -t tlinnet/relax:03 -f Dockerfile_03_user_setup .
alias dr3='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax03 tlinnet/relax:03'

# Build with NMRPipe and MddNMR
docker build -t tlinnet/relax:04 -f Dockerfile_04_NMRPipe_MddNMR .
alias dr4='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax04 tlinnet/relax:04'

# Build base image with packages and relaxwith Palmer, Sparky, Analysis and PyMOL
docker build -t tlinnet/relax:05 -f Dockerfile_05_Palmer_Sparky_Analysis_PyMOL .
alias dr5='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax05 tlinnet/relax:05'

# Build base image with packages and relax
docker build -t tlinnet/relax  .
alias dr='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax tlinnet/relax'