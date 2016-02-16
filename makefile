TOOLCHAIN ?= gnu

MAIN := main stm32f4xx_it system_stm32f4xx ts_calibration usbh_conf
BSP := lcd sdram ts
BSP := stm32f429i_discovery $(addprefix stm32f429i_discovery_, $(BSP)) ili9341 stmpe811
HAL := cortex dma dma2d gpio hcd i2c ltdc rcc rcc_ex sdram spi
HAL := stm32f4xx_hal $(addprefix stm32f4xx_hal_, $(HAL)) stm32f4xx_ll_fmc stm32f4xx_ll_usb
FATFS := diskio ff ff_gen_drv
USBH := core ctlreq diskio ioreq msc msc_bot msc_scsi pipes
USBH := $(addprefix usbh_, $(USBH))

ifeq (gnu,$(TOOLCHAIN))
AS = arm-none-eabi-as
CC = arm-none-eabi-gcc -fno-short-enums
CFLAGS = -mlittle-endian -mthumb -mthumb-interwork -mcpu=cortex-m4 -fsingle-precision-constant -Wdouble-promotion -mfpu=fpv4-sp-d16 -mfloat-abi=hard -nostdlib
ASFLAGS = -mlittle-endian -mthumb -mthumb-interwork -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard
LDFLAGS = -Wl,-T,stm32f429xx_flash.ld
MAIN += sbrk startup_stm32f429xx
else
ifeq (arm,$(TOOLCHAIN))
CC = armclang
CFLAGS = --target=arm-arm-none-eabi -mcpu=cortex-m4 -mfpu=fpv4-sp-d16
LDFLAGS =
else
$(error TOOLCHAIN must be provided: "$$ make TOOLCHAIN=gnu" or "$$ make TOOLCHAIN=arm")
endif
endif

CFLAGS += -DSTM32F429xx -g -O0 -Iinclude -Iinclude/BSP -Iinclude/HAL -Iinclude/CMSIS -Iinclude/fonts -Iinclude/FatFs -Iinclude/USBH

BASENAMES := \
	$(addprefix src/, $(MAIN)) \
	$(addprefix src/BSP/, $(BSP)) \
	$(addprefix src/HAL/, $(HAL)) \
	$(addprefix src/FatFs/, $(FATFS)) \
	$(addprefix src/USBH/, $(USBH))

OBJECTS := $(addprefix build/, $(addsuffix .o, $(BASENAMES)))

.SUFFIXES: .o .c .s

all: lcd

lcd: $(OBJECTS)
	mkdir -p $(shell dirname $@) && $(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

build/%.o: %.c
	mkdir -p $(shell dirname $@) && $(CC) $(CFLAGS) -c $< -o $@

build/%.o: %.s
	mkdir -p $(shell dirname $@) && $(AS) $(ASFLAGS) -c $< -o $@

write: lcd
	stlink/install/bin/st-flash write ./lcd 0x8000000

clean:
	rm -rf build

