FROM debian:testing-slim

ARG debian_control_path

RUN apt update \
 && apt install --no-install-recommends -yV \
    build-essential \
    devscripts \
    equivs \
    wget

WORKDIR /build/
RUN wget https://github.com/open-quantum-safe/openssl/archive/OQS-OpenSSL_1_1_1-stable-snapshot-2020-07.tar.gz
RUN echo "eadb95c4d688f5b1321f1f637a6da9cfbe7ead4bd3a40005b7b4642ae41ba11d OQS-OpenSSL_1_1_1-stable-snapshot-2020-07.tar.gz" | sha256sum --check --status
RUN tar -zxvf OQS-OpenSSL_1_1_1-stable-snapshot-2020-07.tar.gz
RUN mv openssl-OQS-OpenSSL_1_1_1-stable-snapshot-2020-07/ openssl-1.1.1g/

COPY ./debian/ openssl-1.1.1g/debian/

# Set the env variables to non-interactive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

# Install the build deps for _this_ package
RUN mk-build-deps -irt 'apt-get --no-install-recommends -yV' openssl-1.1.1g/debian/control

RUN echo '#!/bin/sh\n\
set -x\n\
dpkg -i /debs/*.deb\n\
cd /build/openssl-1.1.1g\n\
debuild -b -uc -us -nc\n'\
>> /run.sh

RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
