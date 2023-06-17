# base image
FROM --platform=linux/amd64 ubuntu:20.04
WORKDIR  /usr/src/app

ENV DEBIAN_FRONTEND=noninteractive

# update the base packages + add a non-sudo user
RUN apt-get update -y && apt-get upgrade -y && useradd -m docker

# install the packages and dependencies along with jq so we can parse JSON (add additional packages as necessary)
RUN apt-get install -y --no-install-recommends sudo ruby cmake curl nodejs wget unzip vim git jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip

# cd into the user directory, download and unzip the github actions runner
RUN mkdir actions-runner && cd actions-runner && curl -o actions-runner-linux-x64-2.305.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.305.0/actions-runner-linux-x64-2.305.0.tar.gz && tar xzf ./actions-runner-linux-x64-2.305.0.tar.gz

# install some additional dependencies
RUN chown -R docker ~docker && actions-runner/bin/installdependencies.sh

# set the user to "docker" so all subsequent commands are run as the docker user
USER docker

# set the entrypoint to the start.sh script
CMD ["/bin/bash"]

# docker compose up -d
# docker exec -it <ID> bash
# cd /usr/src/app

# apt update && apt install -y curl
# RUNNER_ALLOW_RUNASROOT="1" ./config.sh --url https://github.com/cu-ecen-aeld/assignment-1-petercorrea --token AHWXQGIVCTGZ2PHSSND2Y6DERRRQE
# ./bin/installdependencies.sh
# export GITHUB_ACTIONS_RUNNER_TLS_NO_VERIFY=1
# RUNNER_ALLOW_RUNASROOT="1" ./run.sh

# sudo service docker status
# sudo service docker start