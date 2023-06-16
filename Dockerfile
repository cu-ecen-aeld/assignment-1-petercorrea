FROM ubuntu:20.04
WORKDIR  /usr/src/app
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y build-essential ruby cmake git
EXPOSE 3000
CMD ["/bin/bash"]

# docker build -t devbox .
# docker run -it devbox bash
#  docker compose up -d
# docker exec -it <ID> bash