## Open Quantum Safe OpenSSL Debian files
This repository contains the files for generating Debian distribution packages for the [openssl](https://github.com/open-quantum-safe/openssl) fork that adds quantum-safe key exchange and authentication algorithms.
The Debian files present in this repository are forked from the official Debian [upstream](https://salsa.debian.org/debian/openssl/). This repository contains the full upstream history of openssl which diverges heavily from our target fork, so we decided keep manual track of the changes.

## Build
The Docker image in this repository builds the openssl packages. E.g.
```shell
$ docker build . -t openssl_build
```
This Docker container expects the following volume:
  - **/debs/**: directory containing the Debian packages for the `liboqs` and `liboqs-dev` dependencies (not present in official Debian repositories)
  - **/output/**: where the resulting Debian package will be placed
```shell
$ docker run -v `pwd`/debs:/debs -v `pwd`/output:/output openssl_build
```
