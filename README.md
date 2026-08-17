# pico-sdk-docker
a docker version sdk for Raspberry Pi Pico

[![Docker Pulls](https://img.shields.io/docker/pulls/xianii/pico-sdk)](https://hub.docker.com/r/xianii/pico-sdk)
[![Docker Image Version](https://img.shields.io/docker/v/xianii/pico-sdk?sort=semver)](https://hub.docker.com/r/xianii/pico-sdk)

Image tags follow the official [pico-sdk](https://github.com/raspberrypi/pico-sdk) release (currently **2.3.0**). `latest` points at the same image. The image is for cross-compiling UF2 firmware only — no flash/debug tools.

## Usage

First, you should pull the image.

```bash
docker pull xianii/pico-sdk:2.3.0
```

Then, visit the [example project](https://github.com/Nigh/pico-docker-example) and follow the instructions.

## Build

> [!WARNING]  
> Follow the steps below only if you want to build the image locally.


The build uses [chsrc](https://github.com/RubyMetric/chsrc) to speed up apt. In case you want to specific a mirror, visit the chsrc repo for the avaliable mirror list.

```bash
docker build -t xianii/pico-sdk:2.3.0 --build-arg MIRROR=none .
```

To build a different official SDK release (picotool must have the same tag):

```bash
docker build -t xianii/pico-sdk:2.3.0 --build-arg PICO_SDK_VERSION=2.3.0 .
```

## FQ

如果你所在的地区访问apt默认源的速度较慢，可以使用下面的参数通过`chsrc`测速或手动指定一个源。  
If you are in a region where access to the apt default source is slow, you can either speed test through `chsrc` or specify a source manually using the following parameters.
```bash
# set apt source mirror with speedtest (default)
docker build -t xianii/pico-sdk:2.3.0 .
# specific a mirror
docker build -t xianii/pico-sdk:2.3.0 --build-arg MIRROR=ustc .
```
