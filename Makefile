
CC := arm-none-eabi-gcc
OBJCOPY:=arm-none-eabi-objcopy
LD:=arm-none-eabi-ld

CFLAGS:=-Wall -Wextra -I./src/plib -I./src/core_lib -Os -fdata-sections -ffunction-sections -Wl,--gc-sections -std=c99 -mcpu=cortex-m3 -mthumb --specs=rdimon.specs -lgcc -lc -lm -lrdimon

# Directories
BUILD_DIR:=build
OBJ_DIR:=$(BUILD_DIR)/obj
BIN_DIR:=$(BUILD_DIR)/bin
SRC_DIR:=src

# Create the build directory structure if first run
ifneq ($(BUILD_DIR),)
$(shell [ -d $(BUILD_DIR) ] || mkdir -p $(BUILD_DIR))
$(shell [ -d $(OBJ_DIR) ] || mkdir -p $(OBJ_DIR))
$(shell [ -d $(BIN_DIR) ] || mkdir -p $(BIN_DIR))
endif

# Source files
SRCS:=$(wildcard $(SRC_DIR)/*.c)

# Object files
OBJS:=$(patsubst %.c,$(OBJ_DIR)/%.o,$(notdir $(SRCS)))

# ELF file output
ELF:=$(BIN_DIR)/out.elf
HEX:=$(ELF:.elf=.hex)
BIN:=$(ELF:.elf=.bin)


all: $(ELF)

$(ELF): $(OBJS)
	$(LD) $^ -TSTM32F103C8T6.ld -o $(ELF)
	$(OBJCOPY) -O ihex $(ELF) $(HEX)
	$(OBJCOPY) -O binary $(ELF) $(BIN)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) $^ -o $@

flash:
	st-flash write build/bin/out.bin 0x08000000

clean:
	rm -f $(OBJS)
	rm -f $(ELF)
	rm -f $(HEX)
	rm -f $(BIN)
