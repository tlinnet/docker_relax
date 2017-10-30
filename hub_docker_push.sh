export DOCKER_ID_USER=$USER

# Push to docker
docker login
 
# Image 1
docker tag $USER/relax:01 $DOCKER_ID_USER/relax:01
docker push $DOCKER_ID_USER/relax:01

# Image 2
docker tag $USER/relax:02 $DOCKER_ID_USER/relax:02
docker push $DOCKER_ID_USER/relax:02

# Image 3
docker tag $USER/relax:03 $DOCKER_ID_USER/relax:03
docker push $DOCKER_ID_USER/relax:03

# Image 4
docker tag $USER/relax:04 $DOCKER_ID_USER/relax:014
docker push $DOCKER_ID_USER/relax:04

# Image 5
docker tag $USER/relax:05 $DOCKER_ID_USER/relax:05
docker push $DOCKER_ID_USER/relax:05

# Image 6
docker tag $USER/relax:06 $DOCKER_ID_USER/relax:06
docker push $DOCKER_ID_USER/relax:06

# Final image
docker tag $USER/relax $DOCKER_ID_USER/relax
docker push $DOCKER_ID_USER/relax
