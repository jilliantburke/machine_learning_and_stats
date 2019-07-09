**Principal Component Analysis**

The R script here takes in a data frame, and performs principal component analysis (PCA).

 It then graphs the first and second components as a dot plot. 

The colors of the dots are labeled by the group (classification) of the data, which should be in the last column of the input data. 

**Example**

Example data is provided. This data consists of whole genome sequence of environmental samples, and the features are the percentages of bacteria from certain sources (environments) that have been found within the sample using the FOCUS tool. The meta-genomes are grouped according their true source locations (marine, air, freshwater, etc.) 

The expected output of the R script is a dotplot saved to the working directory as a PNG file. An example of this is located in pca_plot.png.

**Usage**

This script does not take any arguments. It can be run by running the script from within same directory as the data, and with the data named sample_data.csv.  

**Dependecies**

R 3.1 or higher

R packages:
1. ddplyr 
2. ggplot 2
