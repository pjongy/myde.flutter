FLUTTER_VERSION=3.27.4

git clone https://github.com/flutter/flutter $INSTALL_PATH/flutter
cd $INSTALL_PATH/flutter
git checkout $FLUTTER_VERSION
flutter doctor -v
