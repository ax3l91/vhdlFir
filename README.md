# VHDL FIR filter
This is a VHDL program that defines a low-pass Finite impulse repsonse filter (FIR filter)

FIRsymmetric is the top module.

The delta is a testbench that passes a "1" so we can get the filter coefficients in the output

testbench reads the data from the file exportedWave. The exported wave has been exported from MATLAB.
