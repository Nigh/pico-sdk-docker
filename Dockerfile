
FROM ubuntu:latest

ARG MIRROR
ARG DEBIAN_FRONTEND=noninteractive

ARG PICO_SDK_PATH=/pico-sdk
ENV PICO_SDK_PATH=${PICO_SDK_PATH}

# install toolchain
RUN apt update && apt install -y curl \
    && curl -fsSL https://github.com/RubyMetric/chsrc/releases/latest/download/chsrc-x64-linux -o ./chsrc \
    && chmod +x ./chsrc && ./chsrc set ubuntu ${MIRROR} \
    && apt update && apt install -y --no-install-recommends \
        git cmake ninja-build build-essential python3 \
        gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib \
    && ./chsrc reset ubuntu \
    && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 克隆 Pico-SDK
RUN git clone --depth=1 --recurse-submodules --shallow-submodules https://github.com/raspberrypi/pico-sdk ${PICO_SDK_PATH} \
	&& git clone --depth=1 https://github.com/raspberrypi/picotool.git && cd picotool \
	&& mkdir build && cd build && cmake .. && make install && cd / && rm picotool -rf

