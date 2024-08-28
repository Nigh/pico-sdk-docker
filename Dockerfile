
FROM ubuntu:latest

ARG MIRROR=
ENV PICO_SDK_PATH=/pico-sdk

RUN apt update && apt install -y curl \
&& curl -o ./chsrc -L "https://github.com/RubyMetric/chsrc/releases/latest/download/chsrc-x64-linux" \
&& chmod +x ./chsrc && ./chsrc set ubuntu ${MIRROR} \
&& DEBIAN_FRONTEND=noninteractive apt install -y git cmake ninja-build build-essential python3 gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib \
&& git clone --depth=1 --recurse-submodules --shallow-submodules https://github.com/raspberrypi/pico-sdk \
&& git clone --depth=1 https://github.com/raspberrypi/picotool.git && cd picotool \
&& mkdir buiuld && cd build && cmake .. && make install && cd / && rm picotool -rf \
&& ./chsrc reset ubuntu \
&& apt clean && rm -rf /var/lib/apt/lists/*
