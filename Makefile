COMPILER = avr-gcc
LFLAGS = -mmcu=atmega328p -Wall -Os

SRC_DIR = src
OUT_DIR = build

build: $(SRC_DIR)/blink.c
	mkdir -p build
	$(COMPILER) $(CFLAGS) $(LFLAGS) -o $(OUT_DIR)/blink.elf $(SRC_DIR)/blink.c
	avr-objcopy -j .text -j .data -O ihex $(OUT_DIR)/blink.elf $(OUT_DIR)/blink.hex

burn: build
	avrdude -c arduino -p m328p -P /dev/cu.usbmodem142321 -U flash:w:$(OUT_DIR)/blink.hex

all: burn

.PHONY : clean

# make clean - remove .o files and the executable file.
clean:
	rm -frd $(OUT_DIR)

