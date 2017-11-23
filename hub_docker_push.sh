export DOCKER_ID_USER=$USER

# Push to docker
docker login
 
# Image 1
#docker tag $USER/relax:01_packages $DOCKER_ID_USER/relax:01_packages
docker push $DOCKER_ID_USER/relax:01_packages

# Image 2
#docker tag $USER/relax:02_python $DOCKER_ID_USER/relax:02_python
docker push $DOCKER_ID_USER/relax:02_python

# Image 3
#docker tag $USER/relax:03_user_setup $DOCKER_ID_USER/relax:03_user_setup
docker push $DOCKER_ID_USER/relax:03_user_setup

# Image 4
#docker tag $USER/relax:04_NMRPipe_MddNMR $DOCKER_ID_USER/relax:04_NMRPipe_MddNMR
docker push $DOCKER_ID_USER/relax:04_NMRPipe_MddNMR

# Image 5
#docker tag $USER/relax:05_Palmer_Sparky_Analysis_PyMOL $DOCKER_ID_USER/relax:05_Palmer_Sparky_Analysis_PyMOL
docker push $DOCKER_ID_USER/relax:05_Palmer_Sparky_Analysis

# Image 6
#docker tag $USER/relax:06_mmass $DOCKER_ID_USER/relax:06_mmass
docker push $DOCKER_ID_USER/relax:06_mmass

# Image 7
docker push $DOCKER_ID_USER/relax:07_Jupyter

# Image 10
#docker tag $USER/relax:10_relax $DOCKER_ID_USER/relax:10_relax
docker push $DOCKER_ID_USER/relax:10_relax

# Final image
#docker tag $USER/relax $DOCKER_ID_USER/relax
docker push $DOCKER_ID_USER/relax
