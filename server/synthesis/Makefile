DEVICE    = 5k
FOOTPRINT = sg48

all:
	# if build folder doesn't exist, create it
	mkdir -p "$(BUILD_DIR)"

	# synthesize using Yosys
	yosys -p "synth_ice40 -top $(TOP_MODULE) -json $(BUILD_DIR)/out.json" $(BUILD_DIR)/*.v

	# Place and route using arachne
	touch "$(BUILD_DIR)/pinmap.pcf"
	nextpnr-ice40 --up5k --package $(FOOTPRINT)\
		--asc "$(BUILD_DIR)/out.asc" --pcf "$(BUILD_DIR)/pinmap.pcf"\
		--json "$(BUILD_DIR)/out.json"

	# Convert to bitstream using IcePack
	icepack "$(BUILD_DIR)/out.asc" "$(BUILD_DIR)/out.bin"

	# Compress bitstream for flashing
	bash bin_to_bc.sh "$(BUILD_DIR)/out.bin" &>/dev/null

clean:
	rm build/*

.PHONY: all clean
