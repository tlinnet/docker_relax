# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/

FROM ubuntu:16.04

# Layering RUN instructions and generating commits conforms to the
# core concepts of Docker where commits are cheap and containers
# can be created from any point in an images history, much like source control.

# Install packages
RUN apt-get update

RUN apt-get update && \
    apt-get install -y \
        dx lynx htop curl tcsh \
        subversion git scons grace \        
        openmpi-bin openmpi-doc libopenmpi-dev \
        python-numpy python-scipy python-matplotlib python-pip python-wxgtk3.0


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


# Modify PATH.
ENV PATH="/home/developer/bin:${PATH}"
