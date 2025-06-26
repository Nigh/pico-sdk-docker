
FROM ubuntu:latest

ARG MIRROR
ARG DEBIAN_FRONTEND=noninteractive

ARG GITHUB_PROXY
ENV GITHUB_PROXY=${GITHUB_PROXY}
ENV PICO_SDK_PATH=/pico-sdk
ENV WORKDIR=/workspace

# install toolchain
RUN apt update && apt install -y curl ca-certificates \
    && curl -fsSL ${GITHUB_PROXY}https://github.com/RubyMetric/chsrc/releases/latest/download/chsrc-x64-linux -o ./chsrc \
    && chmod +x ./chsrc && ./chsrc set ubuntu ${MIRROR} \
    && apt update && apt install -y --no-install-recommends \
        git cmake ninja-build build-essential xz-utils python3-minimal openssh-server \
    && ./chsrc reset ubuntu \
    && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -L ${GITHUB_PROXY}https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/download/v12.2.1-1.2/xpack-arm-none-eabi-gcc-12.2.1-1.2-linux-x64.tar.gz | \
    tar -xz -C /opt && \
    ln -s /opt/xpack-arm-none-eabi-gcc-12.2.1-1.2 /opt/arm-toolchain
ENV PATH="/opt/xpack-arm-none-eabi-gcc-12.2.1-1.2/bin:${PATH}"

# Clone Pico-SDK
RUN git clone --depth=1 --recurse-submodules --shallow-submodules ${GITHUB_PROXY}https://github.com/raspberrypi/pico-sdk ${PICO_SDK_PATH}
RUN git clone --depth=1 ${GITHUB_PROXY}https://github.com/raspberrypi/picotool.git && cd picotool \
	&& mkdir build && cd build && cmake .. && make install && cd / && rm picotool -rf

# Verify toolchain
RUN arm-none-eabi-gcc --version && \
    make --version && \
    cmake --version && \
    ninja --version

WORKDIR ${WORKDIR}

# In case Dev Containers NOT works
RUN mkdir /var/run/sshd \
    && echo "root:root" | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
