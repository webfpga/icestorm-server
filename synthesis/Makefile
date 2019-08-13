# Project setup
PROJ      = icestorm_example
BUILD     = ./build
#DEVICE    = 8k
#DEVICE    = iCE40UP5K
DEVICE    = 5k
#FOOTPRINT = ct256
FOOTPRINT = sg48

# Files
FILES = blinky.v

.PHONY: all clean burn

all:
	# if build folder doesn't exist, create it
	mkdir -p $(BUILD)
	# synthesize using Yosys
	yosys -p "synth_ice40 -top fpga_top -blif $(BUILD)/$(PROJ).blif" $(FILES)
	# Place and route using arachne
	arachne-pnr -d $(DEVICE) -P $(FOOTPRINT) -o $(BUILD)/$(PROJ).asc -p pinmap.pcf $(BUILD)/$(PROJ).blif
	# Convert to bitstream using IcePack
	icepack $(BUILD)/$(PROJ).asc $(BUILD)/$(PROJ).bin

	bash bin_to_bc.sh $(BUILD)/$(PROJ).bin &>/dev/null

flash:
	npx webfpga-cli flash build/icestorm_example.bin.cbin

#burn:
	#iceprog $(BUILD)/$(PROJ).bin

clean:
	rm build/*
