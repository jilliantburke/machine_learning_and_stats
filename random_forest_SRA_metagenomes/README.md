**Metagenomic Source Location Classification (Predition)**

The program predicts a source classification for each metagenome (e.g. freshwater, marine water, human, animal, etc.) with roughly 80% accuracy. These metagenomes can be either RNAseq or shotgun DNAseq, but not amplicon/16s rRNA seq.

This classifier is based on the random forest method and uses as input features the outputs of the PARTIE and FOCUS tools. For information on how to recreate the input data - as well as scripts that will organize the data into the table format here, see https://github.com/jilliantburke/metagenome_source_prediction_tool/blob/master/protocol.pdf

The program also creates a graph containing the within-group error rates for each level of the classifier (source envrionment). An example of this output in located in outof_box_error_chart.png.

**Example**

Sample dataset is provided here. It is named df_data.csv. 

**Usage**

Simply run this script from the same directory as the data file. The data file must remain named "sample_data.csv." 


**Dependecies** 

R software 3.1 or higher

R Packages: 
1. dplyr
2. ggplot2
3. randomForest



