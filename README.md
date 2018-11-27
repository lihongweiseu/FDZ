### MATLAB codes for 'Fractional differential bearing models for base-isolated buildings: Framework development'

1.  ***isol_run.m*** is the main m-file, run this can get all the evaluation criteria values.
2.	***earthquake_select.m*** and ***evaluation_criteria.m*** are functions used in ***isol_run.m***.
3.	The seven txt-files are the earthquakes.
4.	***STRUC.mat*** is the data of the structure used in ***isol_run.m***. Run ***STRUC_run_this_to_get.m*** can get ***STRUC.mat*** for the benchmark building. Users can check that or define their structure.
5.	***fss_2016a.slx*** is the Simulink model used in ***isol_run.m***.
6.	***fss_sf.m*** is the S-function for the ‘Bearing’ part in the ***fss_2016a.slx***. 

The ***example*** folder is to draw the response plots for certain earthquake excitation. Default is sylmar. The following is the instruction for this folder.

1.	***example_run.m*** is the main m-file, run this can get all the response results for selected earthquake.
2.	***compare_with_FFT.m*** can show the response plots based on the proposed framework and the FT method. There are more detailed instructions in this m-file. Please pay attention.
3.	After running ***example_run.m***, run ***plot_resp.m*** can see the plots of the response based on SS method.

The ***Systems_ID*** folder is to identify the systems.

1.	Run ***input_output.m*** to get the file ***input_output_xyr.mat***.
2.	Run ***System_ID.m*** to identify the systems.
3.	***TF_Freq_Damp.m*** is the function used in ***System_ID.m***.
