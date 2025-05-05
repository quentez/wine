FROM ubuntu:25.04

# Install dependencies.
RUN \
  dpkg --add-architecture i386 && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    make \
    cmake \
    flex \
    bison \
    libx11-dev \
    libxext-dev \
    libxrandr-dev \
    libxi-dev \
    libxcursor-dev \
    libxinerama-dev \
    libxkbcommon-dev \
    libxkbregistry-dev \
    libxkbregistry-dev:i386 \
    libxkbcommon-dev:i386 \
    libxdamage-dev \
    libxcomposite-dev \
    libxshmfence-dev \
    libgl1-mesa-dev \
    libvulkan-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libgnutls28-dev \
    libncurses5-dev \
    libxml2-dev \
    libxslt1-dev \
    libudev-dev \
    libasound2-dev \
    libpulse-dev \
    libdbus-1-dev \
    libfontconfig1-dev \
    liblcms2-dev \
    libgsm1-dev \
    libjpeg8-dev \
    libtiff5-dev \
    libmpg123-dev \
    libgphoto2-dev \
    libpcap-dev \
    libopenal-dev \
    libv4l-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libcapi20-dev \
    libcups2-dev \
    libkrb5-dev \
    libldap2-dev \
    libgettextpo-dev \
    gettext \
    libwayland-bin \
    libwayland-dev \
    libwayland-dev:i386 \
    gcc-multilib \
    g++-multilib \
    libc6-dev-i386 \
    libx11-dev:i386 \
    libfreetype6-dev:i386 \
    libncurses5-dev:i386 \
    libxxf86vm-dev \
    libosmesa6-dev \
    libpcsclite-dev \
    libsane-dev \
    libusb-1.0-0-dev \
    libsdl2-dev \
    oss4-base \
    oss4-dev \
    libsmbclient-dev \
    opencl-headers \
    ocl-icd-opencl-dev \
    p7zip-full \
    git \
    gcc-mingw-w64

# Copy source.
COPY ./ /tmp/wine/

# Build.
RUN \
  mkdir -p /tmp/winebuild64 && \
  cd /tmp/winebuild64 && \
  PKG_CONFIG_PATH=/usr/lib/i386-linux-gnu/pkgconfig ../wine/configure --enable-archs=i386,x86_64 --prefix=/tmp/wine-install --with-wayland --with-opencl --enable-win64

RUN cd /tmp/winebuild64 && make -j$(nproc)
RUN cd /tmp/winebuild64 && make install

CMD ["bash"]
