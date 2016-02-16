```
$ cd stlink/
$ ./autogen.sh 
$ mkdir build
$ cd build/
$ sudo apt-get install libusb-1.0-0-dev
$ ../configure --prefix=$(pwd)/../../install
$ make -j12
$ make install
```

