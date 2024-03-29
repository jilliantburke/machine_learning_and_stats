#this script performs a PCA analysis and plots the data
#note that the file paths are hardcoded and so lines 5 (input) and 31 (output) must be changed!

library(dplyr)
library(ggplot2)

#this.dir <- dirname(parent.frame(2)$ofile)
#setwd(this.dir)
#setwd('~')
getwd()
data <- read.table('sample_data.csv', sep=',', header=TRUE)


#strip out the ID's and the Source info bc these can't be scaled
dat<-data[,-1]
row.names(dat) <- paste(dat$source, row.names(dat), sep="_") 
dat$source <- NULL


# SCALE THE VALUES
dat.scaled <- data.frame(scale(dat))

# CALCULATED THE PCA
dat.pca <- prcomp(dat.scaled, center = FALSE, scale. = FALSE)
eigs <- dat.pca$sdev^2
var1=(eigs[1] / sum(eigs))*100
var2=(eigs[2] / sum(eigs))*100
xlabel<-c("PC",var1)

rownames(dat.pca)

df_out <- as.data.frame(dat.pca$x)
df_out$group <- sapply( strsplit(as.character(row.names(dat)), "_"), "[[", 1 )

#library(ggplot2)

png("pca_plot.png", width = 11, height = 9, units = 'in', res = 300)

percentage <- round(dat.pca$sdev / sum(dat.pca$sdev) * 100, 2)
percentage <- paste( colnames(df_out), "(", paste( as.character(percentage), "%", ")", sep="") )
p<-ggplot(df_out,aes(x=PC1,y=PC2,color=group))
p<-p+ggtitle('Principle Component 2 vs 1','colored by source category')+xlab('Level') +
  ylab('Error Rate') 
p<-p+geom_point() + xlab(percentage[1]) + ylab(percentage[2])
p

dev.off()

print("PCA plot is complete and located in the file pca_plot.png!")
