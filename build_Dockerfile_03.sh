# To build this image, source the file

# Build user setup
docker build -t $USER/relax:03_user_setup -f Dockerfile_03_user_setup .
alias dr3='docker run -ti --rm -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work --name relax03 $USER/relax:03_user_setup'
# Docker relax Jupyter notebook
alias dr3j='docker run -ti --rm -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work -p 8888:8888 --name relax03 $USER/relax:03_user_setup'
alias dr3n='docker run -ti --rm -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work -p 8888:8888 --name relax03 $USER/relax:03_user_setup jupyter-notebook --debug --no-browser --port 8888 --ip=0.0.0.0'
alias dr3l='docker run -ti --rm -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work -p 8888:8888 --name relax03 $USER/relax:03_user_setup jupyter-lab --debug --no-browser --port 8888 --ip=0.0.0.0'