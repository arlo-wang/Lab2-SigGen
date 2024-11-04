#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vsinegen.h"

#include "vbuddy.cpp"

#define MAX_SIM_CYC 1000000
#define ADDRESS_WIDTH 8
#define ROM_SZ 256

int main(int argc, char **argv, char **env) {
    // i counts the number of clock cycles to simulate.
    // clk is the module clock signal.
    int simcyc;
    int tick;

    Verilated::commandArgs(argc, argv);
    // init top verilaog instance
    Vsinegen* top = new Vsinegen;
    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("sinegen.vcd");

    if (vbdOpen()!=1) return(-1);
    vbdHeader("L2T1: SigGen");
    //vbdSetMode(1);        // Flag mode set to one-shot

    // initialize simulation inputs
    top->clk = 1;
    top->rst = 0;
    top->en = 1;
    top->incr = 1;

    for (simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++) {

        // dump variables into VCD file and toggle clock
        for (tick = 0; tick < 2; tick++) {
            tfp->dump (2*simcyc+tick);  // unit is in ps!!!
            top->clk = !top->clk;
            top->eval ();
        }

        top->incr = vbdValue();
        vbdPlot(int (top->dout), 0, 255);
        vbdCycle(simcyc);

        // either simulation finished, or 'q' is pressed
        if ((Verilated::gotFinish()) || (vbdGetkey()=='q'))  exit(0);
    }

    vbdClose();
    tfp->close();
    exit(0);
}
