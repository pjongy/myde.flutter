FROM pjongy/myde:5.0.0-amd64

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=dev
ENV USERNAME=$USERNAME
ARG INSTALL_PATH=/home/$USERNAME/installed
ENV INSTALL_PATH=$INSTALL_PATH
ARG HOME_PATH=/home/$USERNAME
ENV HOME_PATH=$HOME_PATH

RUN sudo apt update \
  && sudo apt install unzip cmake meson ninja-build cmake clang -y \
  && pip3 install meson==1.7.0

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip -O $INSTALL_PATH/commandlinetools-linux-7302050_latest.zip
RUN unzip $INSTALL_PATH/commandlinetools-linux-7302050_latest.zip
RUN mkdir $INSTALL_PATH/android
RUN mv cmdline-tools $INSTALL_PATH/android
RUN mkdir $INSTALL_PATH/android/cmdline-tools/tools/
RUN mv $INSTALL_PATH/android/cmdline-tools/bin $INSTALL_PATH/android/cmdline-tools/tools
RUN mv $INSTALL_PATH/android/cmdline-tools/lib $INSTALL_PATH/android/cmdline-tools/tools

# android sdk (command line tools)
ENV ANDROID_SDK_ROOT=$INSTALL_PATH/android
ENV ANDROID_HOME=$INSTALL_PATH/android

# NOTE: "JAVA_HOME=$HOME/.jabba/jdk/$(jabba ls | head -n 1)" to find available java which is installed via jabba
RUN yes "y" | JAVA_HOME=$HOME_PATH/.sdkman/candidates/java/current \
  $INSTALL_PATH/android/cmdline-tools/tools/bin/sdkmanager "build-tools;29.0.3"
RUN yes "y" | JAVA_HOME=$HOME_PATH/.sdkman/candidates/java/current \
  $INSTALL_PATH/android/cmdline-tools/tools/bin/sdkmanager "platforms;android-29"
RUN yes "y" | JAVA_HOME=$HOME_PATH/.sdkman/candidates/java/current \
  $INSTALL_PATH/android/cmdline-tools/tools/bin/sdkmanager "platform-tools"
RUN yes "y" | JAVA_HOME=$HOME_PATH/.sdkman/candidates/java/current \
  $INSTALL_PATH/android/cmdline-tools/tools/bin/sdkmanager "cmdline-tools;latest"
RUN yes "y" | JAVA_HOME=$HOME_PATH/.sdkman/candidates/java/current \
  $INSTALL_PATH/android/cmdline-tools/tools/bin/sdkmanager --licenses

ENV ANDROID_SDK_ROOT="$INSTALL_PATH/android"
ENV ANDROID_HOME="$INSTALL_PATH/android"
ENV PATH="$PATH:$INSTALL_PATH/flutter/bin:$INSTALL_PATH/android/cmdline-tools/tools/bin:$INSTALL_PATH/android/platform-tools"

# install flutter
COPY --chown=$USERNAME arch/amd64/installer/* $INSTALL_PATH/installer/
RUN $INSTALL_PATH/installer/flutter.sh

COPY --chown=$USERNAME ./HELP.myde.flutter $HOME_PATH/HELP.myde.flutter
RUN cat $HOME_PATH/HELP.myde.flutter >> $HOME_PATH/HELP
RUN rm $HOME_PATH/HELP.myde.flutter
