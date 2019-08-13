DEVICE    = 5k
FOOTPRINT = sg48

all:
	# if build folder doesn't exist, create it
	mkdir -p $(BUILD_DIR)

	# synthesize using Yosys
	yosys -p "synth_ice40 -top fpga_top -blif $(BUILD_DIR)/$(PROJ).blif"\
		$(VERILOG_SOURCE_DIR)/*.v

	# Place and route using arachne
	arachne-pnr -d $(DEVICE) -P $(FOOTPRINT) -o $(BUILD_DIR)/$(PROJ).asc\
				-p $(VERILOG_SOURCE_DIR)/pinmap.pcf $(BUILD_DIR)/$(PROJ).blif

	# Convert to bitstream using IcePack
	icepack $(BUILD_DIR)/$(PROJ).asc $(BUILD_DIR)/$(PROJ).bin

	# Compress bitstream for flashing
	bash bin_to_bc.sh $(BUILD_DIR)/$(PROJ).bin &>/dev/null

clean:
	rm build/*

.PHONY: all clean
