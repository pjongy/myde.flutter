# myde for flutter

my develop environment for flutter

## start
```
$ docker run --rm -v "$PWD/project:/home/dev/project" pjongy/myde.flutter:{version}
```

## start with usb debugging
```
$ docker run --rm -v "$PWD/project:/home/dev/project" -v /dev/bus/usb:/dev/bus/usb:ro --privileged pjongy/myde.flutter:{version}
```

## build
```
$ docker build . -f arch/arm/Dockerfile -t pjongy/myde.flutter:arm64
$ docker build . -f arch/amd64/Dockerfile -t pjongy/myde.flutter:amd64
```

## help
```
$ cat ~/HELP
```
