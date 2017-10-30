# To build this image, source the file

# Build user setup
docker build -t $USER/relax:03 -f Dockerfile_03_user_setup .
alias dr3='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work --name relax03 $USER/relax:03'
# Docker relax Jupyter notebook
alias dr3j='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work -p 8888:8888 --name relax03 $USER/relax:03'
alias dr3n='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work -p 8888:8888 --name relax03 $USER/relax:03 jupyter-notebook --debug --no-browser --port 8888 --ip=0.0.0.0'
alias dr3l='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work -p 8888:8888 --name relax03 $USER/relax:03 jupyter-lab --debug --no-browser --port 8888 --ip=0.0.0.0'
