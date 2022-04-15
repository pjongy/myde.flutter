FROM pjongy/myde:3.0.0

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=dev
ENV USERNAME $USERNAME
ARG INSTALL_PATH=/home/$USERNAME/installed
ENV INSTALL_PATH $INSTALL_PATH

# install dart
RUN sudo apt-get install -y apt-transport-https
RUN sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
RUN sudo apt-get update
RUN sudo apt-get install -y dart

# flutter
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.2.1-stable.tar.xz -O $INSTALL_PATH/flutter_linux_2.2.1-stable.tar.xz
RUN tar xf $INSTALL_PATH/flutter_linux_2.2.1-stable.tar.xz
RUN mv ./flutter $INSTALL_PATH

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip -O $INSTALL_PATH/commandlinetools-linux-7302050_latest.zip
RUN sudo apt install unzip
RUN unzip $INSTALL_PATH/commandlinetools-linux-7302050_latest.zip
RUN mkdir $INSTALL_PATH/android
RUN mv cmdline-tools $INSTALL_PATH/android
RUN mkdir $INSTALL_PATH/android/cmdline-tools/tools/
RUN mv $INSTALL_PATH/android/cmdline-tools/bin $INSTALL_PATH/android/cmdline-tools/tools
RUN mv $INSTALL_PATH/android/cmdline-tools/lib $INSTALL_PATH/android/cmdline-tools/tools

# android sdk (command line tools)
RUN bash -c 'source "/home/$USERNAME/.jabba/jabba.sh" && jabba install openjdk@1.12.0'
ENV JAVA_HOME /home/$USERNAME/.jabba/jdk/openjdk@1.12.0
ENV ANDROID_SDK_ROOT $INSTALL_PATH/android
ENV ANDROID_HOME $INSTALL_PATH/android

RUN yes "y" | $INSTALL_PATH/android/cmdline-tools/tools/bin/sdkmanager "build-tools;29.0.3"
RUN yes "y" | $INSTALL_PATH/android/cmdline-tools/tools/bin/sdkmanager "platforms;android-29"
RUN yes "y" | $INSTALL_PATH/android/cmdline-tools/tools/bin/sdkmanager "platform-tools"
RUN yes "y" | $INSTALL_PATH/android/cmdline-tools/tools/bin/sdkmanager "cmdline-tools;latest"
RUN yes "y" | $INSTALL_PATH/android/cmdline-tools/tools/bin/sdkmanager --licenses

RUN echo "export JAVA_HOME=/home/$USERNAME/.jabba/jdk/openjdk@1.12.0" >> ~/.zshrc
ENV echo "export ANDROID_SDK_ROOT=$INSTALL_PATH/android" >> ~/.zshrc
ENV echo "export ANDROID_HOME=$INSTALL_PATH/android" >> ~/.zshrc
RUN echo "export PATH=$PATH:$INSTALL_PATH/flutter/bin:$INSTALL_PATH/android/cmdline-tools/tools/bin:$INSTALL_PATH/android/platform-tools" >> ~/.zshrc

COPY --chown=$USERNAME ./HELP.myde.flutter /home/$USERNAME/HELP.myde.flutter
RUN cat /home/$USERNAME/HELP.myde.flutter >> /home/$USERNAME/HELP
RUN rm ~/HELP.myde.flutter
