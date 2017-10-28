# To build this image, source the file

# Build with python
docker build -t tlinnet/relax:02 -f Dockerfile_02_python .
alias dr2='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name relax02 tlinnet/relax:02'
# Docker relax Jupyter notebook
alias dr2n='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work -p 8888:8888 --name relax02 tlinnet/relax02 jupyter-notebook --no-browser --port 8888 --ip=0.0.0.0'
