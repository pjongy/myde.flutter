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

## help
```
$ cat ~/HELP
```
