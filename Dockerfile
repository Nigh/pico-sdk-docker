
FROM ubuntu:latest

ARG MIRROR=

RUN apt update && apt install -y curl \
&& curl -o ./chsrc -L "https://github.com/RubyMetric/chsrc/releases/latest/download/chsrc-x64-linux" \
&& chmod +x ./chsrc && ./chsrc set ubuntu ${MIRROR} && rm ./chsrc \
&& apt install -y git cmake ninja-build python3 gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib \
&& git clone --depth=1 --recurse-submodules --shallow-submodules https://github.com/raspberrypi/pico-sdk \
&& apt clean && rm -rf /var/lib/apt/lists/*

ENV PICO_SDK_PATH=/pico-sdk

