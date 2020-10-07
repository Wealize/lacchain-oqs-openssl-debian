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

## Copyright 2020 LACChain

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.