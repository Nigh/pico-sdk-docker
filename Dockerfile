
FROM ubuntu:latest

ARG MIRROR
ARG DEBIAN_FRONTEND=noninteractive

ARG PICO_SDK_PATH=/pico-sdk
ENV PICO_SDK_PATH ${PICO_SDK_PATH}

ADD https://github.com/RubyMetric/chsrc/releases/latest/download/chsrc-x64-linux ./chsrc

RUN apt update && apt install -y curl \
&& chmod +x ./chsrc && ./chsrc set ubuntu ${MIRROR} && apt update \
&& apt install -y git cmake ninja-build build-essential python3 gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib \
&& git clone --depth=1 --recurse-submodules --shallow-submodules https://github.com/raspberrypi/pico-sdk \
&& git clone --depth=1 https://github.com/raspberrypi/picotool.git && cd picotool \
&& mkdir build && cd build && cmake .. && make install && cd / && rm picotool -rf \
&& ./chsrc reset ubuntu \
&& apt clean && rm -rf /var/lib/apt/lists/*
