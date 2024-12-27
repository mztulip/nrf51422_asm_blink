
CROSS_COMPILE ?= /home/tulip/gcc-arm-none-eabi-7-2017-q4-major-linux/gcc-arm-none-eabi-7-2017-q4-major/bin/arm-none-eabi-

CC=$(CROSS_COMPILE)gcc
AS=$(CROSS_COMPILE)as
LD=$(CROSS_COMPILE)ld
OBJCOPY=$(CROSS_COMPILE)objcopy
OBJDUMP=$(CROSS_COMPILE)objdump

all: nrf51_blink.elf nrf51_blink.bin nrf51_blink.lst

.PHONY: clean

%.elf:  %.S
	$(CC) -mcpu=cortex-m0 -mthumb -nostartfiles  $< -Ttext 0x0000000 -o $@

%.lst: %.elf
	$(OBJDUMP) -S $< > $@

%.bin: %.elf
	$(OBJCOPY) -Obinary $< $@

clean:
	-rm -f *.elf *.lst *.bin *.o

flash:
	-openocd -c 'adapter driver jlink; transport select swd;set WORKAREASIZE 0' -f target/nrf51.cfg -c "init;reset;init;halt;flash write_image erase nrf51_blink.bin 0x0;reset;shutdown"