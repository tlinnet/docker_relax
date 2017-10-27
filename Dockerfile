# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/
# docker build -t tlinnet/relax .

FROM tlinnet/relax:05

# Get relax
# http://www.nmr-relax.com
RUN cd $HOME && \
    cd $HOME/software && \
    git clone https://github.com/nmr-relax/relax.git relax && \
    cd $HOME/software/relax && \
    git pull && \
    scons && \
    ./relax -i && \
    ln -s $HOME/software/relax/relax $HOME/bin/relax

# Expose to run jupyter notebook
EXPOSE 8888
