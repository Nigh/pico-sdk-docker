# pico-sdk-docker
a docker version sdk for Raspberry Pi Pico

## build

The build uses [chsrc](https://github.com/RubyMetric/chsrc) to speed up apt. In case you want to specific a mirror, visit the chsrc repo for the avaliable mirror list.

```bash
# set apt source mirror with speedtest (default)
docker build -t pico-sdk .
# specific a mirror
docker build -t pico-sdk --build-arg MIRROR=ustc .
# without mirror
docker build -t pico-sdk --build-arg MIRROR=none .
```
