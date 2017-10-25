# Docker for NMR software
Docker image for building NMR software on Ubuntu

Includes builded software for:

* [relax](http://www.nmr-relax.com/)
* [NMRPipe](https://www.ibbr.umd.edu/nmrpipe/install.html)
* [Art Palmers ModelFree4](http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software)
* [MddNMR](http://mddnmr.spektrino.com/download)

# Get prebuild image:
```bash
docker pull tlinnet/docker_relax
docker images
```

## Running on a mac
On mac, first make sure XQuartz is running

```bash
open -a XQuartz
# In XQuartz -> Preferences > Security, 
# make sure the tick "Allow connections 
# from network clients" is ON.
```

Then set DISPLAY options. First veriy:

```bash
# Its either of these. Check which one return IP addr.
ipconfig getifaddr en1
ipconfig getifaddr en0
 
# Run appropriate
xhost + `ipconfig getifaddr en1`
xhost + `ipconfig getifaddr en0`
```

Then make alias and run
[Link to run reference:](https://docs.docker.com/v1.11/engine/reference/commandline/run)

```bash
alias dr='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name ubuntu_relax tlinnet/docker_relax'

# -t : Allocate a pseudo-TTY
# -i : interactive. Keep STDIN open even if not attached
# --rm : Automatically remove the container when it exits
# -e : --env=[]  Set environment variables
# -v : --volume=[host-src:]container-dest[:<options>]. Bind mount a volume.
# --name : Assign a name to the container
# IMAGE
```

Then try to run programs after making the **dr** alias:

```bash
# Start relax
dr relax
```

To make this easier, consider adding this to **HOME/.bash_profile**

```bash
# Start docker, if it is not running
alias drdocker='open -a /Applications/Docker.app/Contents/MacOS/Docker'
# Start  XQuartz, if it is not running
alias drx='open -a XQuartz; xhost + `ipconfig getifaddr en1`'
# Alias the docker run command
alias dr='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name ubuntu_relax tlinnet/docker_relax'
```

To open a bash terminal in the container, when it is running

```bash
docker exec -it ubuntu_relax bash
```

# Installed programs
## relax
```bash
# Start relax in GUI
dr relax -g
# Start OpenDX
dr dx
# Try OpenMPI
dr mpirun --version
dr mpirun -np 2 echo "hello world"
dr mpirun --report-bindings -np 2 echo "hello world"
```
## nmrPipe
```bash
# Start nmrDraw. It apparently takes 1-2 min to open window?
dr nmrDraw
```

# Delete container and images
This will destroy all your images and containers. **It will not be possible to restore them!**

Delete all containers:

```bash
docker ps
docker rm $(docker ps -a -q)
```

Delete all dangling images

```bash
docker images -f dangling=true
docker rmi $(docker images -qf dangling=true)
```

Delete all images

```bash
docker images
docker rmi $(docker images -q)
```

# Build own image
[Link to build reference:](https://docs.docker.com/v1.11/engine/reference/commandline/build)

```bash
docker build -t docker_relax .
# -t : --tag=[]  Name and optionally a tag in the 'name:tag' format
# PATH

# On Linux
docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name ubuntu_relax docker_relax

# On mac
xhost + `ipconfig getifaddr en1`
docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/home/developer/work --name ubuntu_relax docker_relax

```



### Made from
* <http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker> <br>
* <https://blog.jessfraz.com/post/docker-containers-on-the-desktop>

