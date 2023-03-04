Targeted for Efinix's Efinity 2022.2.322

This is trying to get register retiming working with heavy timing path (floating point reciprocal).

1. Run synthesis
2. Tools => View Timing Browser
3. Tools => Show/Hide Tcl Command Console

Run the following TCL commands from Command Console:
- `report_timing -from a_data_d1[0]*|Q -npath 10`
- `report_timing -from a_data_d2[0]*|Q -npath 10`
- `report_timing -from b_data_d1[0]*|Q -npath 10`

From Timing Browser you can see that all "calculation" is done on a_data_d2 => b_data_d1 datapath. All other paths are pure register-to-register paths.

How to get register retiming working?
