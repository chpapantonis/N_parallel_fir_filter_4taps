# N_parallel_fir_filter_4taps
4 taps fir filter with fully parallel from 1 to 16. 

This filter is written in vhdl code and it is fully parallelized. Initially it is a 4tap fir filter. The value of each coefficient is passed by generics(parameters) in each tap_module. Coefficients are created by passing through the  interger and fractional part and the multiplication is done with shifts and not with multiplier. 

A SiPo(Serian In Parallel Out) is taking sequentially the data from the input and distribute them accordingly in the MIMO (Multiple In Muliple Out)which is respospible for all the parallel implementation of the filter. The SiPo takes the parallelism parameter and gives the corresponding parallel output. The PiSo module (Parallel in Serial Out) takes as input the multiple outputs on the MIMO module and transmits them in a serial way to the BCD module which is responsible for the diplay of the outpu in the 7 segment display. 

For human reason (so output can be readable for the human eye in the display) we have used a clock divider of 1 Hz whick is the main clock for the ROM,PISO and SIPO modules.

