# Docker for NMR software
Docker image for NMR software. Running on Ubuntu 16.04 LTS.

The [README with links can be found by clicking here](https://github.com/tlinnet/docker_relax/blob/master/README.md)

The purpose is to make a container with relevant NMR software for daily processing of data. 

Consider this workflow:

* Unpack data with commands **bruker**, **varian** or **qMDD** to test.ft2
* Inspect test.ft2 in **nmrDraw** or start a **JupyterLab**, and make images with **nmrglue** and matplotlib.
* Use the **JupyterLab**, to write your work process and include images and math text.
* Prepare data files in **JupyterLab**
* Execute a script for **relax**, depending on the data files.

You now have a Jupyter notebook, with images+math+workflow, which you can share and send to collaborators. 

**This images includes software for:**

* [relax](http://www.nmr-relax.com/) with [OpenDX](http://wiki.nmr-relax.com/OpenDX) -> [Jump to commands](#relax)
* [NMRPipe](https://www.ibbr.umd.edu/nmrpipe/install.html) -> [Jump to commands](#NMRPipe)
* [MddNMR](http://mddnmr.spektrino.com/download) -> [Jump to commands](#MddNMR)
* [nmrglue](https://www.nmrglue.com/) -> [Jump to commands](#nmrglue)
* Art Palmers software: [ModelFree4](http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/modelfree), [FastModelFree](http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/modelfree), [Quadric](http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/quadric-diffusion), [PDBinertia](http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/pdbinertia) -> [Jump to commands](#Palmer)
* [Sparky](http://www.cgl.ucsf.edu/home/sparky) -> [Jump to commands](#Sparky)
* [CcpNmr Analysis 2.4](http://www.ccpn.ac.uk/v2-software/downloads) -> [Jump to commands](#Analysis)
* [JupyterLab](http://jupyter.org)-> [Jump to commands](#Jupyter)
* [Pymol](https://pymolwiki.org/index.php/Main_Page)-> [Jump to commands](#Pymol)
* [mMass Mass Spectrometry Tool](http://mmass.org/)-> [Jump to commands](#mmass)
* [Atom text editor](https://atom.io/)

For deleting images, go to -> [Developer section](#Developer)<br>
For examples, go to -> [Examples section](#examples)

# Get prebuild image:
```bash
docker pull tlinnet/relax
```
# Running docker with image <a name="run"></a>
[Link to run reference:](https://docs.docker.com/v1.11/engine/reference/commandline/run)

```bash
# See images on machine
docker images
```
## Running on a mac <a name="runmac"></a>
```bash
# First make sure XQuartz is running
open -a XQuartz
# In XQuartz -> Preferences > Security, make sure the tick 
# "Allow connections from network clients" is ON.

# Then set DISPLAY options. Verify if to use en1 or en0:
xhost + `ipconfig getifaddr en1`

# Then make alias and run. Set 'en1' to either en1 or en0, depending which returns IP.
alias dr='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work --name relax tlinnet/relax'
# Run it
dr
```
## Easy run of docker by adding alias to shell profile file
To make this easier on a **mac**, consider adding this to **HOME/.bash_profile**

```bash
# Start docker, if it is not running
alias drdocker='open -a /Applications/Docker.app/Contents/MacOS/Docker'
# Start  XQuartz, if it is not running
alias drx='open -a XQuartz; xhost + `ipconfig getifaddr en1`'

# Run "Docker Relax": dr
alias dr='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work --name relax tlinnet/relax'

# Run "Docker Relax Execute ": For example: dre bash
# This is when then Docker Relax image is already running.
alias dre='docker exec -it relax'

# Docker Relax Jupyter notebook: drn
alias drn='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work -p 8888:8888 --name relax tlinnet/relax jupyter-notebook --no-browser --port 8888 --ip=0.0.0.0'

# Docker relax JupyterLab: drl
alias drl='docker run -ti --rm -e DISPLAY=$(ipconfig getifaddr en1):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/developer/work -p 8888:8888 --name relax tlinnet/relax jupyter-lab --no-browser --port 8888 --ip=0.0.0.0'
```
# Installed programs
## relax with OpenDX <a name="relax"></a>
* [relax](http://www.nmr-relax.com/) with [OpenDX](http://wiki.nmr-relax.com/OpenDX)

```bash
# Start relax in GUI
dr relax -g

# Start OpenDX
dr dx

# Try OpenMPI for running with multiple CPU. Not tested.
# To start into bash
dr 
# Then in terminal try
mpirun --version
mpirun -np 2 echo "hello world"
mpirun --report-bindings -np 2 echo "hello world"
```
## nmrPipe 
* [NMRPipe](https://www.ibbr.umd.edu/nmrpipe/install.html)

```bash
# Start nmrDraw. It apparently takes 1-2 min to open window?
dr
nmrDraw
```
## MddNMR <a name="MddNMR"></a>
* [MddNMR](http://mddnmr.spektrino.com/download)

```bash
# First need to start terminal before running qMDD
dr
qMDD
```
## nmrglue <a name="nmrglue"></a>
* [nmrglue](https://www.nmrglue.com/)

Have a look here, for longer example together with JupyterLab [is explained here.](#nmrglue_ex)

```bash
dr python -c "import nmrglue; print nmrglue.__version__"
```


## Art Palmers software <a name="Palmer"></a>
* Art Palmers: [ModelFree4](http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/modelfree), [FastModelFree](http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/modelfree), [Quadric](http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/quadric-diffusion), [PDBinertia](http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/pdbinertia)

```bash
# modelfree
dr modelfree4

# FastModelFree
dr setupFMF

# quadric-diffusion
dr quadric_diffusion
dr r2r1_tm

# PDBinertia
dr pdbinertia
```
## Sparky <a name="Sparky"></a>
* [Sparky](http://www.cgl.ucsf.edu/home/sparky)

```bash
dr sparky
```
## CcpNmr Analysis 2.4 <a name="Analysis"></a>
* [CcpNmr Analysis 2.4](http://www.ccpn.ac.uk/v2-software/downloads)

```bash
dr analysis
```
## JupyterLab <a name="Jupyter"></a>
First make aliases as described in [aliases for mac](#runmac)

Then run

```bash
# For JupyterLab
drl

# For Jupyter Notebook
drn
```

Then visit in our browser: [http://0.0.0.0:8888](http://0.0.0.0:8888)<br>
NOTE: If you by accident use: **http://0.0.0.0:8888/tree**, the JupyterLab extension will NOT work.

## Pymol <a name="Pymol"></a>
* [Pymol](https://pymolwiki.org/index.php/Main_Page)

Pymol can not run with graphical content.<br>

```bash
dr pymol -c
```
## mMass <a name="mmass"></a>
* [mMass Mass Spectrometry Tool](http://mmass.org/)-> [Jump to commands](#mmass)

GUI for working with Mass Spectrometry

```bash
dr mmass
# Open mzML files right away
dr mmass Analysis.mzML
```
# Developer <a name="Developer"></a>

To open a bash terminal in the container, when it is running

```bash
docker exec -it relax bash
```
## Build own image.
[Link to build reference:](https://docs.docker.com/v1.11/engine/reference/commandline/build)

This will build 6 docker images, chained after each other.
This is to save time in the building phase.

1. Image makes apt-get install of packages
2. Install python packages with pip
3. Setup the user "developer" with sudo password: passwd
4. Setup NMRPipe and qMDD
5. Setup Palmers software, Sparky and Analysis
6. Setup mMass
7. Clone and scons build relax
8. Build the main Dockerfile, with relax updated last

```bash
source build_Dockerfile.sh
```
Restart docker on a mac, if it "hangs".

```bash
killall Docker
drdocker
```

Delete container and images. This will destroy all your images and containers. <br>
**It will not be possible to restore them!**

```bash
# Delete all containers:
docker ps
docker rm $(docker ps -a -q)
docker rm --force $(docker ps -a -q)

# Delete all dangling images
docker images -f dangling=true
docker rmi $(docker images -qf dangling=true)

# Delete all images
docker images
docker rmi $(docker images -q)
```
## References
* <http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker> <br>
* <https://blog.jessfraz.com/post/docker-containers-on-the-desktop>

# Examples of use <a name="examples"></a>
## nmrglue in JupyterLab <a name="nmrglue_ex"></a>

First go to a folder, on your computer, where you can download nmrglue example files.

* [nmrglue examples](https://github.com/jjhelmus/nmrglue/tree/master/examples)
* [nmrglue archive](https://code.google.com/archive/p/nmrglue/downloads)

```bash
# First make a directory where to download example files
mkdir -p $HOME/Downloads/nmrglue_ex
cd $HOME/Downloads/nmrglue_ex
```

### separate/separate_2d_bruker
This example contains a Python script separate.py which separates 2D spectra from an array of 2D data in a Bruker data set.

We can use curl and unzip from the container already. 

```bash
cd $HOME/Downloads/nmrglue_ex
dr curl -O https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/nmrglue/example_separate_2d_bruker.zip
dr unzip example_separate_2d_bruker.zip
```

Then start a JupyterLab. The **drl** alias [is explained here.](#runmac)

```bash
# Start Docker Relax Labbook
drl
```
Then visit in our browser: [http://0.0.0.0:8888](http://0.0.0.0:8888).

Create a new Python 3 notebook. Paste this is into cells, and execute 
with shift+enter

```python
import nmrglue as ng

# read in the NMR data
dic, data = ng.bruker.read('separate_2d_bruker/arrayed_data.dir', shape=(7360, 640), cplex=True)
```

```python
# Write it out
array_size = 23
for i in range(array_size):
    dir_name = "separate_2d_bruker/%02d"%(i)
    print("Creating directory:", dir_name)
    ng.bruker.write(dir_name, dic, data[i::array_size], overwrite=True)

# list files
%ls separate_2d_bruker/00
```
Voila!

### jbnmr_examples/s4_2d_plotting
This example is taken from Listing S4 from the 2013 JBNMR nmrglue paper. In this example a 2D SSNMR spectrum is visualized using the script plot_2d_pipe_spectrum.py

```bash
cd $HOME/Downloads/nmrglue_ex
curl -O https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/nmrglue/jbnmr_s4_2d_plotting.zip
unzip jbnmr_s4_2d_plotting.zip
```
Then start a JupyterLab. The **drl** alias [is explained here.](#runmac)

```bash
# Start Docker Relax Labbook
drl
```
Then visit in our browser: [http://0.0.0.0:8888](http://0.0.0.0:8888).

Create a new Python 3 notebook. Paste this is into cells, and execute 
with shift+enter

```bash
%ls s4_2d_plotting

import nmrglue as ng
import matplotlib.pyplot as plt
%matplotlib inline

# read in data
dic, data = ng.pipe.read("s4_2d_plotting/test.ft2")

# find PPM limits along each axis
uc_15n = ng.pipe.make_uc(dic, data, 0)
uc_13c = ng.pipe.make_uc(dic, data, 1)
x0, x1 = uc_13c.ppm_limits()
y0, y1 = uc_15n.ppm_limits()

# plot the spectrum
fig = plt.figure(figsize=(10, 10))
fig = plt.figure()
ax = fig.add_subplot(111)
cl = [8.5e4 * 1.30 ** x for x in range(20)]
ax.contour(data, cl, colors='blue', extent=(x0, x1, y0, y1), linewidths=0.5)

# add 1D slices
x = uc_13c.ppm_scale()
s1 = data[uc_15n("105.52ppm"), :]
s2 = data[uc_15n("115.85ppm"), :]
s3 = data[uc_15n("130.07ppm"), :]
ax.plot(x, -s1 / 8e4 + 105.52, 'k-')
ax.plot(x, -s2 / 8e4 + 115.85, 'k-')
ax.plot(x, -s3 / 8e4 + 130.07, 'k-')

# label the axis and save
ax.set_xlabel("13C ppm", size=20)
ax.set_xlim(183.5, 167.5)
ax.set_ylabel("15N ppm", size=20)
ax.set_ylim(139.5, 95.5)
fig.savefig("spectrum_2d.png")
```
![Result](https://raw.githubusercontent.com/jjhelmus/nmrglue/master/examples/jbnmr_examples/s4_2d_plotting/spectrum_2d.png)
