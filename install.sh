#!/usr/bin/env bash

command -v docker >/dev/null 2>&1 || {
    echo "Docker not found. Installing..." >&2;
    # Update apt-get
    apt-get update

    # Lets remove any old Docker installations.
    apt-get remove -y docker docker-engine docker-ce docker.io

    # Install Docker dependencies & git.
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common \
        git

    # Adding Docker’s official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # Verify fingerprint
    apt-key fingerprint 0EBFCD88

    # Adding repository
    add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

    # Update apt-get
    apt-get update

    # Install Docker CE
    apt-get install -y docker-ce
}

command -v docker-compose >/dev/null 2>&1 || {
    echo "docker-compose not found. Installing..." >&2;
    # get latest docker compose released tag
    COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)

    # Install docker-compose
    sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
    chmod +x /usr/local/bin/docker-compose

    # Show docker-compose version
    docker-compose --version
    }

docker-compose up -d