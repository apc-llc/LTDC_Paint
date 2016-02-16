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

Build & install the GCC toolchain:

```
$ cd summon-arm-toolchain
$ sudo apt-get install build-essential git flex bison libgmp3-dev libmpfr-dev libncurses5-dev libmpc-dev autoconf texinfo libtool libftdi-dev libusb-1.0-0-dev
$ ./summon-arm-toolchain PREFIX=$(pwd)/../install CPUS=4
```

Build the `LTDC_Paint` sample:
