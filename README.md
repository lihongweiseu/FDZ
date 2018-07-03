### MATLAB codes for 'Simulation of a base-isolated benchmark building with bearings governed by Fractional Derivative Zener model'

1.  ***isol_run.m*** is the main m-file, run this can get all the evaluation criteria values.
2.	***earthquake_select.m*** and ***evaluation_criteria.m*** are functions used in ***isol_run.m***.
3.	The seven txt-files are the earthquakes.
4.	***STRUC.mat*** is the data of the structure used in ***isol_run.m***. Run ***STRUC_run_this_to_get.m*** can get ***STRUC.mat*** for the benchmark building. Users can check that or define their structure.
5.	***fsim_ss_2016a.slx*** is the Simulink model used in ***isol_run.m***.
6.	***fsim.mexw64*** is the S-function for the ‘Bearing’ part in the ***fsim_ss_2016a.slx***.
7.	***fsim.c*** is the source c-file to compile fsim.mexw64. Users can check it. If ***fsim.mexw64*** doesn’t work for some MATLAB versions, users can recompile it. 
8.	***isol_plan.m*** draws the isolation plan for the benchmark building.

The ***example*** folder is to draw the response plots for certain earthquake excitation. Default is El-centro. The following is the instruction for this folder.

1.	***example_run.m*** is the main m-file, run this can get all the response results for selected earthquake.
2.	***compare_with_FFT.m*** can show the response plots based on SS method and FFT method. There are more detailed instructions in this m-file. Please pay attention.
3.	After running ***example_run.m***, run ***plot_resp.m*** can see the plots of the response based on SS method.
