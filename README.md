# pico-sdk-docker
a docker version sdk for Raspberry Pi Pico

## Usage

First, you should pull the image.

```bash
docker pull xianii/pico-sdk:latest
```

Then, visit the [example project](https://github.com/Nigh/pico-docker-example) and follow the instructions.

## Build

> [!WARNING]  
> Follow the steps below only if you want to build the image locally.


The build uses [chsrc](https://github.com/RubyMetric/chsrc) to speed up apt. In case you want to specific a mirror, visit the chsrc repo for the avaliable mirror list.

```bash
docker build -t pico-sdk --build-arg MIRROR=none .
```


## FQ

如果你所在的地区访问apt默认源的速度较慢，可以使用下面的参数通过`chsrc`测速或手动指定一个源。  
If you are in a region where access to the apt default source is slow, you can either speed test through `chsrc` or specify a source manually using the following parameters.
```bash
# set apt source mirror with speedtest (default)
docker build -t pico-sdk .
# specific a mirror
docker build -t pico-sdk --build-arg MIRROR=ustc .
```

如果你所在的地区访问无法正常访问到GitHub，可以如同下面，使用参数`GITHUB_PROXY`指定一个镜像，这个参数会附加在GitHub的链接之前。  
不过，由于`pico-sdk`引用了多个submodule，这个方式无法处理到，所以作用有限。  
If GitHub is not available in your region, you can specify a mirror as below, using the `GITHUB_PROXY` parameter, which will be appended before the GitHub link.  
However, since `pico-sdk` contains multiple submodules, which cannot be handled in this way, it is only of limited use.
```bash
docker build -t pico-sdk --build-arg MIRROR=ustc --build-arg GITHUB_PROXY=https://ghfast.top/ .
```
