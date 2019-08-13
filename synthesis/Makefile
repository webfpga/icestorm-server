BUILD     = ./build
DEVICE    = 5k
FOOTPRINT = sg48

all:
	# if build folder doesn't exist, create it
	mkdir -p $(BUILD)
	# synthesize using Yosys
	yosys -p "synth_ice40 -top fpga_top -blif $(BUILD)/$(PROJ).blif" $(VERILOG_SOURCE_DIR)/*.v
	# Place and route using arachne
	arachne-pnr -d $(DEVICE) -P $(FOOTPRINT) -o $(BUILD)/$(PROJ).asc\
				-p $(VERILOG_SOURCE_DIR)/pinmap.pcf $(BUILD)/$(PROJ).blif
	# Convert to bitstream using IcePack
	icepack $(BUILD)/$(PROJ).asc $(BUILD)/$(PROJ).bin

	bash bin_to_bc.sh $(BUILD)/$(PROJ).bin &>/dev/null

flash:
	npx webfpga-cli flash build/icestorm_example.bin.cbin

clean:
	rm build/*

.PHONY: all clean flash
