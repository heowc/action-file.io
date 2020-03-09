FROM ubuntu:18.04

RUN apt-get update -y & \ 
    apt-get install -y \
    curl \
    jq \
    zip gzip tar \
    findutils & \
    apt-get clean

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]