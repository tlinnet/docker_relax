# Push to docker
docker login
 
# Image 1
docker tag tlinnet/relax:01 $USER/relax:01
docker push $USER/relax:01

# Image 2
docker tag tlinnet/relax:02 $USER/relax:02
docker push $USER/relax:02

# Image 3
docker tag tlinnet/relax:03 $USER/relax:03
docker push $USER/relax:03

# Image 4
docker tag tlinnet/relax:04 $USER/relax:014
docker push $USER/relax:04

# Image 5
docker tag tlinnet/relax:05 $USER/relax:05
docker push $USER/relax:05

# Image 6
docker tag tlinnet/relax:06 $USER/relax:06
docker push $USER/relax:06

# Final image
docker tag tlinnet/relax $USER/relax
docker push $USER/relax
