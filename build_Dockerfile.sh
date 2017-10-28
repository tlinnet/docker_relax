# To build this image, source the file

# Build base image with packages
docker build -t tlinnet/relax:01 -f Dockerfile_01_packages .
alias dr1='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "'$PWD'":/home/developer/work --name relax01 tlinnet/relax:01'

# Build with python
docker build -t tlinnet/relax:02 -f Dockerfile_02_python .
alias dr2='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "'$PWD'":/home/developer/work --name relax02 tlinnet/relax:02'

# Build user setup
docker build -t tlinnet/relax:03 -f Dockerfile_03_user_setup .
alias dr3='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "'$PWD'":/home/developer/work --name relax03 tlinnet/relax:03'
# Docker relax Jupyter notebook
alias dr3j='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "'$PWD'":/home/developer/work -p 8888:8888 --name relax03 tlinnet/relax:03'
alias dr3n='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "'$PWD'":/home/developer/work -p 8888:8888 --name relax03 tlinnet/relax:03 jupyter-notebook --debug --no-browser --port 8888 --ip=0.0.0.0'
alias dr3l='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "'$PWD'":/home/developer/work -p 8888:8888 --name relax03 tlinnet/relax:03 jupyter-lab --debug --no-browser --port 8888 --ip=0.0.0.0'

# Build with NMRPipe and MddNMR
docker build -t tlinnet/relax:04 -f Dockerfile_04_NMRPipe_MddNMR .
alias dr4='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "'$PWD'":/home/developer/work --name relax04 tlinnet/relax:04'

# Build base image with packages and relaxwith Palmer, Sparky, Analysis and PyMOL
docker build -t tlinnet/relax:05 -f Dockerfile_05_Palmer_Sparky_Analysis_PyMOL .
alias dr5='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "'$PWD'":/home/developer/work --name relax05 tlinnet/relax:05'

# Build with mmass
docker build -t tlinnet/relax:06 -f Dockerfile_06_mmass .
alias dr6='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "'$PWD'":/home/developer/work --name relax06 tlinnet/relax:06'

# Build with bruker CompassXport
docker build -t tlinnet/relax:07 -f Dockerfile_07_bruker_CompassXport .
alias dr7='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "'$PWD'":/home/developer/work --name relax07 tlinnet/relax:07'



# Build relax
docker build -t tlinnet/relax:10 -f Dockerfile_10_relax .
alias dr10='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "'$PWD'":/home/developer/work --name relax10 tlinnet/relax:10'

# Build ending image updating relax
docker build -t tlinnet/relax  .

# Docker relax run
alias dr='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "'$PWD'":/home/developer/work --name relax tlinnet/relax'
# Execute in Docker relax when running
alias dre='docker exec -it relax'
# Docker relax Jupyter notebook
alias drn='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "'$PWD'":/home/developer/work -p 8888:8888 --name relax tlinnet/relax jupyter-notebook --no-browser --port 8888 --ip=0.0.0.0'
alias drl='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "'$PWD'":/home/developer/work -p 8888:8888 --name relax tlinnet/relax jupyter-lab --no-browser --port 8888 --ip=0.0.0.0'
