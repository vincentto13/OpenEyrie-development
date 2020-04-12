#/bin/bash

DOCKER_DEV_CONTAINER_NAME="open-eyrie-development"
DOCKER_DEV_IMAGE_NAME="open-eyrie-development-image"

# if [ ! "$(docker images -q $DOCKER_DEV_IMAGE_NAME 2> /dev/null)" ]; then
#     docker build . -t $DOCKER_DEV_IMAGE_NAME
# fi

if [ ! "$(docker ps -q -f name=$DOCKER_DEV_CONTAINER_NAME)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=$DOCKER_DEV_CONTAINER_NAME)" ]; then
        # cleanup
        docker rm $DOCKER_DEV_CONTAINER_NAME
    fi

    # rebuild image if there were any changes
    docker build . -t $DOCKER_DEV_IMAGE_NAME

    # run your container
    docker run -it --rm -v $HOME/.conan:/root/.conan -v $HOME/.ssh:/root/.ssh -v $HOME/.gitconfig:/root/.gitconfig -v $(pwd)/workspace:/root/workspace --name $DOCKER_DEV_CONTAINER_NAME $DOCKER_DEV_IMAGE_NAME
fi