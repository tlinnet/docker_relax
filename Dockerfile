# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/

FROM ubuntu:16.04

# Layering RUN instructions and generating commits conforms to the
# core concepts of Docker where commits are cheap and containers
# can be created from any point in an images history, much like source control.

# Install packages
RUN apt-get update

RUN apt-get update && \
    apt-get install -y \
        dx lynx htop curl wget unzip gawk tcsh \
        subversion git scons grace \        
        openmpi-bin openmpi-doc libopenmpi-dev \
        python-numpy python-scipy python-matplotlib python-pip python-wxgtk3.0 \
        python-pandas python-pyside \
        tk

# NMRPipe
# http://www.lorieau.com/nmr/2015/04/15/NMRPipe-ubuntu14.04.html
# https://www.ibbr.umd.edu/nmrpipe/install.html
RUN dpkg --add-architecture i386
RUN apt-get update && \
    apt-get install -y \
        csh \
        libc6:i386 libstdc++6:i386 libx11-6:i386 \
        libxext6:i386 xfonts-75dpi  default-jre default-jdk

# msttcorefonts has License terms, which needs to be accepted
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections && \
    apt-get install -y msttcorefonts

# Upgrade pip
RUN pip install --upgrade pip

# Install python packages with pip
RUN pip install \
        mpi4py \
        epydoc

# Install relax python pagkages
RUN VMIN=`lynx -dump "http://wiki.nmr-relax.com/Template:Current_version_minfx" | grep -A 10 "Template:Current version minfx" | grep -B 1 "Retrieved from" | head -n 1 | tr -d '[[:space:]]'` && \
    echo "Installing current version of minfx: $VMIN" && \
    mkdir -p $HOME/Downloads && \
    cd $HOME/Downloads && \
    curl https://iweb.dl.sourceforge.net/project/minfx/$VMIN/minfx-$VMIN.tar.gz -o minfx-$VMIN.tar.gz && \
    tar -xzf minfx-$VMIN.tar.gz && \
    cd minfx-$VMIN && \
    pip install . && \
    cd $HOME

RUN VBMR=`lynx -dump "http://wiki.nmr-relax.com/Template:Current_version_bmrblib" | grep -A 10 "Template:Current version bmrblib" | grep -B 1 "Retrieved from" | head -n 1 | tr -d '[[:space:]]'` && \
    echo "Installing current version of bmrblib: $VBMR" && \
    mkdir -p $HOME/Downloads && \
    cd $HOME/Downloads && \
    curl https://iweb.dl.sourceforge.net/project/bmrblib/$VBMR/bmrblib-$VBMR.tar.gz -o bmrblib-$VBMR.tar.gz && \
    tar -xzf bmrblib-$VBMR.tar.gz && \
    cd bmrblib-$VBMR && \
    pip install . && \
    cd $HOME

# Install nmrglue
# https://www.nmrglue.com/
RUN cd $HOME && \
    echo "Installing nmrglue" && \
    mkdir -p $HOME/Downloads && \
    cd $HOME/Downloads && \
    curl -LOk `curl -s https://api.github.com/repos/jjhelmus/nmrglue/releases/latest | grep "browser_download_url" | cut -d: -f2,3 | tr -d \" `
RUN cd $HOME && \
    cd $HOME/Downloads && \
    tar -xzf nmrglue-*.tar.gz && \
    cd nmrglue-* && \
    pip install . && \
    cd $HOME

# Add user: After this, no installing to system directories is possible.
# -m : Create the home directory if it does not exist.
# -s : User's login shell, which defaults to /bin/bash
RUN useradd -ms /bin/bash developer
USER developer
RUN mkdir -p $HOME/work
WORKDIR /home/developer/work

# Stop Gtk-WARNING 
RUN mkdir -p $HOME/.local/share

# Get relax
# http://www.nmr-relax.com
RUN cd $HOME && \
    mkdir -p $HOME/software && \
    cd $HOME/software && \
    git clone git://git.code.sf.net/p/nmr-relax/code relax && \
    cd $HOME/software/relax && \
    git pull && \
    scons && \
    ./relax -i && \
    mkdir -p $HOME/bin && \
    ln -s $HOME/software/relax/relax $HOME/bin/relax && \
    cd $HOME

# Add Palmers Modelfree
# http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/modelfree
RUN cd $HOME && \
    echo "Installing Palmers Modelfree" && \
    mkdir -p $HOME/Downloads && \
    cd $HOME/Downloads && \
    curl http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/modelfree/modelfree_linux64.tar.gz -o modelfree_linux64.tar.gz && \
    tar -xzf modelfree_linux64.tar.gz && \
    mkdir -p $HOME/software && \
    mv linux64 $HOME/software/modelfree4 && \
    ln -s $HOME/software/modelfree4/modelfree4 $HOME/bin/modelfree4 && \
    cd $HOME

# NMRPipe
# http://www.lorieau.com/nmr/2015/04/15/NMRPipe-ubuntu14.04.html
# https://www.ibbr.umd.edu/nmrpipe/install.html
RUN cd $HOME && \
    echo "Installing NMRPipe" && \
    mkdir -p $HOME/software/NMRPipe && \
    cd $HOME/software/NMRPipe && \
    curl -O https://www.ibbr.umd.edu/nmrpipe/install.com && \
    curl -O https://www.ibbr.umd.edu/nmrpipe/binval.com && \
    curl -O https://www.ibbr.umd.edu/nmrpipe/NMRPipeX.tZ && \
    curl -O https://www.ibbr.umd.edu/nmrpipe/s.tZ && \
    curl -O https://www.ibbr.umd.edu/nmrpipe/dyn.tZ && \
    curl -O https://www.ibbr.umd.edu/nmrpipe/talos.tZ && \
    curl -O https://spin.niddk.nih.gov/bax/software/smile/plugin.smile.tZ    
# Run install.
# ./install.com +help to generate a list of install 
RUN cd $HOME && \
    cd $HOME/software/NMRPipe && \
    chmod a+r NMRPipeX.tZ && \
    chmod a+r s.tZ && \
    chmod a+r dyn.tZ && \
    chmod a+r talos.tZ && \
    chmod a+r plugin.smile.tZ && \
    chmod a+rx install.com && \
    chmod a+rx binval.com
RUN cd $HOME && \
    cd $HOME/software/NMRPipe && \
    touch /home/developer/.cshrc && \
    ./install.com
# Made from: source /home/developer/software/NMRPipe/com/nmrInit.linux212_64.com
ENV NMRBASE=/home/developer/software/NMRPipe
ENV PATH="$NMRBASE/nmrbin.linux212_64:$NMRBASE/com:${PATH}"
ENV NMR_IO_TIMEOUT=0
ENV NMR_IO_SELECT=0
ENV NMR_AUTOSWAP=1
ENV NMR_PLUGIN_FN=SMILE
ENV NMR_PLUGIN_EXE=nusPipe
ENV NMR_PLUGIN_INFO="-nDim -sample sName ... MD NUS Reconstruction"
ENV MANPATH=$NMRBASE/man:/usr/share/man:/usr/local/man:${MANPATH}
ENV MANPATH=$NMRBASE/man:/usr/share/man:/usr/local/man
ENV LD_LIBRARY_PATH=$NMRBASE/nmrbin.linux212_64/lib:${LD_LIBRARY_PATH}
#ENV LD_LIBRARY_PATH=$NMRBASE/nmrbin.linux212_64/lib
ENV OPENWINHOME=$NMRBASE/nmrbin.linux212_64/openwin
ENV NMR_CHECKARGS=ALL
ENV NMR_FSCHECK=NO
ENV NMRBINTYPE=linux212_64
ENV NMRTXT=$NMRBASE/nmrtxt
ENV NMRBIN=$NMRBASE/nmrbin.linux212_64
ENV TCLPATH=$NMRBASE/com
ENV TALOS_DIR=$NMRBASE/talos
ENV TALOSP_DIR=$NMRBASE/talosplus
ENV TALOSN_DIR=$NMRBASE/talosn
ENV SPARTAP_DIR=$NMRBASE/spartaplus
ENV PROMEGA_DIR=$NMRBASE/promega
ENV NMR_TCLTK8=TRUE
ENV TCL_LIBRARY=$NMRBASE/nmrtcl/tcl8.4
ENV TK_LIBRARY=$NMRBASE/nmrtcl/tk8.4
ENV BLT_LIBRARY=$NMRBASE/nmrtcl/blt2.4
ENV NMRPIPE_TCL_LIB=$NMRBASE/nmrtcl/tcl8.4
ENV NMRPIPE_TK_LIB=$NMRBASE/nmrtcl/tk8.4
ENV NMRPIPE_BLT_LIB=$NMRBASE/nmrtcl/blt2.4
# Made from: source /home/developer/software/NMRPipe/dynamo/com/dynInit.com
ENV DYNAMO_KEY=2002084
ENV DYNAMO_DIR=$NMRBASE/dynamo
ENV DYNAMO_PARAMS=$NMRBASE/dynamo/params
ENV SURF_DIR=$NMRBASE/dynamo/surface
ENV PDBH_BASE=$NMRBASE/pdb
ENV PDBH_DIR=$PDBH_BASE/pdbH
ENV PDBH_LIST=$PDBH_BASE/pdbH.list
ENV PDBH_TAB=$PDBH_BASE/resolution.tab

# MddNMR
# http://mddnmr.spektrino.com/download
RUN cd $HOME && \
    echo "Installing MddNMR" && \
    mkdir -p $HOME/Downloads && \
    cd $HOME/Downloads && \
    curl -L -O https://github.com/tlinnet/docker_relax/raw/master/mddnmr2.5.tgz
RUN cd $HOME && \
    cd $HOME/Downloads && \
    tar xvf mddnmr2.5.tgz && \
    mv mddnmr $HOME/software/mddnmr
RUN cd $HOME && \
    cd $HOME/software/mddnmr && \
    ./Install
# Set environment for MddNMR
ENV PATH=".:${PATH}:$MDD_NMRbin:${MDD_NMR}/com"
ENV MDD_NMR=/home/developer/software/mddnmr 
ENV MDD_NMRbin=${MDD_NMR}/binCentOS64Static 

# Add Palmers Quadric
# http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/quadric-diffusion
RUN cd $HOME && \
    echo "Installing Palmers Quadric" && \
    mkdir -p $HOME/Downloads && \
    cd $HOME/Downloads && \
    curl -O http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/quadric-diffusion/quadric_linux64.tar.gz && \
    tar -xzf quadric_linux64.tar.gz && \
    mkdir -p $HOME/software && \
    mv linux $HOME/software/quadric && \
    ln -s $HOME/software/quadric/linux_64/quadric_diffusion $HOME/bin/quadric_diffusion && \
    ln -s $HOME/software/quadric/linux_64/r2r1_tm $HOME/bin/r2r1_tm && \
    cd $HOME

# Add Palmers PDBinertia
# http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/quadric-diffusion
RUN cd $HOME && \
    echo "Installing Palmers PDBinertia" && \
    mkdir -p $HOME/Downloads && \
    cd $HOME/Downloads && \
    curl -O http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/pdbinertia/pdbinertia_linux64.tar.gz && \
    tar -xzf pdbinertia_linux64.tar.gz && \
    mkdir -p $HOME/software && \
    mv linux $HOME/software/pdbinertia && \
    ln -s $HOME/software/pdbinertia/linux_64/pdbinertia $HOME/bin/pdbinertia && \
    cd $HOME

# Add Palmers FastModelFree
# http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/modelfree
RUN cd $HOME && \
    echo "Installing Palmers FastModelFree" && \
    mkdir -p $HOME/Downloads && \
    cd $HOME/Downloads && \
    curl -O http://comdnmr.nysbc.org/comd-nmr-dissem/comd-nmr-software/software/modelfree/FASTModelFree.zip && \
    unzip FASTModelFree.zip && \
    mkdir -p $HOME/software && \
    mv FASTModelFree $HOME/software/FASTModelFree && \
    ln -s $HOME/software/FASTModelFree/setupFMF $HOME/bin/setupFMF && \
    cd $HOME

# Sparky - NMR Assignment and Integration Software
# http://www.cgl.ucsf.edu/home/sparky/
RUN cd $HOME && \
    echo "Installing SPARKY" && \
    mkdir -p $HOME/Downloads && \
    cd $HOME/Downloads && \
    curl -O http://www.cgl.ucsf.edu/home/sparky/distrib-3.115/sparky-linux2.6-64bit.tar.gz && \
    tar -xzf sparky-linux2.6-64bit.tar.gz && \
    mv sparky $HOME/software/sparky
RUN cd $HOME && \
    mkdir -p $HOME/Sparky && \
    mkdir -p $HOME/Sparky/Projects && \
    mkdir -p $HOME/Sparky/Save && \
    mkdir -p $HOME/Sparky/Lists
# Set environment for sparky
ENV PATH="${PATH}:/home/developer/software/sparky/bin"
ENV SPARKYHOME=/home/developer/Sparky

# CcpNmr Analysis 2.4
# http://www.ccpn.ac.uk/v2-software/software/analysis
# http://www.ccpn.ac.uk/v3-software/downloads/beta-downloads
# http://www.ccpn.ac.uk/v2-software/downloads
RUN cd $HOME && \
    echo "Installing CcpNmr Analysis 2.4" && \
    mkdir -p $HOME/Downloads && \
    cd $HOME/Downloads && \
    curl -O http://www2.ccpn.ac.uk/download/ccpnmr/analysis2.4.2_linux64.tgz
#curl -O http://www2.ccpn.ac.uk/download/ccpnmr/analysis2.4.2_ubuntu16.tgz
RUN cd $HOME && \
    cd $HOME/Downloads && \
    tar xvf analysis2.4.2_linux64.tgz
#tar xvf analysis2.4.2_ubuntu16.tgz
RUN cd $HOME && \
    cd $HOME/Downloads && \
    mv ccpnmr $HOME/software/ccpnmr
# Set environment for analysis
ENV CCPNMR_TOP_DIR=/home/developer/software/ccpnmr
ENV PATH="${CCPNMR_TOP_DIR}/bin:${PATH}"
ENV PYTHONPATH=.:${CCPNMR_TOP_DIR}/ccpnmr2.1/python

RUN cd $HOME && \
    echo "Installing CcpNmr Analysis format convert" && \
    mkdir -p $HOME/Downloads && \
    cd $HOME/Downloads && \
    curl -O http://www2.ccpn.ac.uk/download/ccpnmr/format2.4.0.tar.gz && \
    tar xvf format2.4.0.tar.gz && \
    mv ccpnmr ccpnmr_format

# Modify PATH.
ENV PATH="/home/developer/bin:${PATH}"
