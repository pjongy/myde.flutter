FROM --platform=linux/arm64/v8 pjongy/myde:5.0.0-arm

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=root
ENV USERNAME=$USERNAME
ARG HOME_PATH=/root
ENV HOME_PATH=$HOME_PATH
ARG INSTALL_PATH=/root/installed
ENV INSTALL_PATH=$INSTALL_PATH

RUN apt update \
  && apt install unzip cmake meson ninja-build cmake clang -y \
  && pip3 install meson==1.7.0


# NOTE: android sdk is only for x64 arch (arm is not allowed)

ENV PATH="$PATH:$INSTALL_PATH/flutter/bin"

# install flutter
COPY arch/arm/installer/* $INSTALL_PATH/installer/
RUN $INSTALL_PATH/installer/flutter.sh

COPY ./HELP.myde.flutter $HOME_PATH/HELP.myde.flutter
RUN cat $HOME_PATH/HELP.myde.flutter >> $HOME_PATH/HELP
RUN rm $HOME_PATH/HELP.myde.flutter
RUN echo "ANDROID SDK FOR ARM IS NOT SUPPORTED" >> $HOME_PATH/HELP
