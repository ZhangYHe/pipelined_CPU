onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib inst_men_opt

do {wave.do}

view wave
view structure
view signals

do {inst_men.udo}

run -all

quit -force
