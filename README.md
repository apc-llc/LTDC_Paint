Checkout sample source code and dependencies:

```
$ git clone https://github.com/apc-llc/LTDC_Paint
$ cd LTDC_Paint
$ git submodule init
$ git submodule update
```

Build & install `stlink`:

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

