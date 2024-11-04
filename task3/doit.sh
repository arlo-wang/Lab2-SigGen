#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f sigdelay.vcd

# run verilator to translate Verilog into C++, including C++ testbench
verilator -Wall --cc --trace sigdelay.sv counter.sv ram2ports.sv --exe sigdelay_tb.cpp

# build C++ project via make automatically generated by Verilator
make -j -C obj_dir/ -f Vsigdelay.mk Vsigdelay

# run excutable simulation file
obj_dir/Vsigdelay

ls /dev/tty.u*
