## ActionTestScript linux-base

## Quick Start

Open a terminal and run the following command:

```
docker run --rm -it actiontestscript/linux-base sh
```
## Docker files :
- [linux base](https://github.com/ats-docker/linux-base.git) (this image)

### Others images :
- [linux browsers](https://github.com/ats-docker/linux-browsers.git) : ` docker pull actiontestscript/linux-browsers `
- [linux](https://github.com/ats-docker/linux.git) : ` docker pull actiontestscript/linux `
- [ActionTestScript Docker images on Windows](https://hub.docker.com/r/actiontestscript/windows)

## Description
Linux base machine with minimalistic tools to launch ATS test execution.

Image based images. It build from ubuntu:lunar. It contains the following packages:
  - curl
  - git
  - unzip
  - zip
  - bzip2
  - nvi
  - psmisc
  - iproute2
  - java openjdk 21.0.1
  - maven mvn 3.9.6