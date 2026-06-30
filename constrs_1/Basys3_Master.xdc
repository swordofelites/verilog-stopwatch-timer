## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Mode Switches (`mode_switch[1:0]`)
set_property PACKAGE_PIN V17 [get_ports {mode[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {mode[0]}]
set_property PACKAGE_PIN V16 [get_ports {mode[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {mode[1]}]

## Preset Switches (`preset_switch[7:0]`)
set_property PACKAGE_PIN W16 [get_ports {preset[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {preset[0]}]
set_property PACKAGE_PIN W17 [get_ports {preset[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {preset[1]}]
set_property PACKAGE_PIN W15 [get_ports {preset[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {preset[2]}]
set_property PACKAGE_PIN V15 [get_ports {preset[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {preset[3]}]
set_property PACKAGE_PIN W14 [get_ports {preset[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {preset[4]}]
set_property PACKAGE_PIN W13 [get_ports {preset[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {preset[5]}]
set_property PACKAGE_PIN V2 [get_ports {preset[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {preset[6]}]
set_property PACKAGE_PIN T3 [get_ports {preset[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {preset[7]}]

## Buttons
set_property PACKAGE_PIN U18 [get_ports reset]
	set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property PACKAGE_PIN T18 [get_ports startstop]
	set_property IOSTANDARD LVCMOS33 [get_ports startstop]

## Seven Segment Display (Cathodes a-g)
set_property PACKAGE_PIN W7 [get_ports {seg[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]
set_property PACKAGE_PIN W6 [get_ports {seg[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property PACKAGE_PIN U8 [get_ports {seg[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property PACKAGE_PIN V8 [get_ports {seg[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property PACKAGE_PIN V5 [get_ports {seg[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property PACKAGE_PIN U7 [get_ports {seg[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
	
## Anodes (Digit Enable)
set_property PACKAGE_PIN U2 [get_ports {an[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]
	
## Decimal Point
set_property PACKAGE_PIN V7 [get_ports dp]							
	set_property IOSTANDARD LVCMOS33 [get_ports dp]