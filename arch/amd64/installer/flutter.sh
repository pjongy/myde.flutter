FLUTTER_VERSION=3.27.4

wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION-stable.tar.xz -O $INSTALL_PATH/flutter_linux_$FLUTTER_VERSION-stable.tar.xz
tar xf $INSTALL_PATH/flutter_linux_$FLUTTER_VERSION-stable.tar.xz
mv ./flutter $INSTALL_PATH
