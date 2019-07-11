# NOTE: filepaths are hardcoded
#lines 14 (input file path) and 38 (output file path) must be changed before running

#this script runs a random forest model on the input data provided and produces two plots
#1.plots as bar graph of OOB error rate by level of source category
#2. plot of variable importance in model

#the input data required here is a table of arbitrary size,
#however the first column must be unique identifiers of each observations
#the last column must be the classifications (ground truth)
#all other columns must contain only numeric values (because the data will be scaled)

library(dplyr)
library(ggplot2)
library(randomForest)

#
# import data and adjust the first column(sra_ids) to be the row names
#
data<-read.csv('rf_data.csv', header=T)
rownames(data)<-data[,1]
data<-data[,-1]

#######################################
#calculate z-scores
#######################################
data.scaled<-data[,-length(colnames(data))] #remove the 'source" (ground truth) value bc they are not numeric
data.scaled<-data.frame(scale(data.scaled))
data.scaled$source<-data$source #ad the source back in

#
#run random forest (note no split of training and testing data is required by RF)
#
rf_model<-randomForest(formula=as.factor(source)~.,data=data.scaled,importance=TRUE,proximity=TRUE,ntree=2500)
                       

#
#calculate error rates by class level
#
cf_mat<-data.frame(rf_model$confusion)
error<-data.frame(cf_mat$class.error)
error$level<-rownames(cf_mat)

#
#plot of within-group errors
#
png("oob_error_unbal_min50.png", width = 11, height = 9, units = 'in', res = 300)
error %>%
  arrange(cf_mat.class.error) %>%
  mutate(level=factor(level, levels=level)) %>%
  ggplot(aes(x = level, y = cf_mat.class.error)) + 
  theme_bw() + geom_bar(stat = "identity") +xlab('Level') +
  scale_y_continuous(name="Error Rate", expand=c(0,0),limits=c(0,1.0))+
  theme(panel.grid.minor = element_blank()) +
  theme(axis.line = element_line(colour = "black")) +
  theme(axis.text=element_text(size=14),
        axis.title=element_text(size=16,face="bold")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
  ggtitle("Out of Bag Error by Level of Output Variable")

dev.off()

#
#plot variable importance
#

png("var_importance_unbal_min50.png", width = 11, height = 9, units = 'in', res = 300)
plot.new()
varImpPlot(rf_model,type=1, pch=19, main='Variable Importance')#, xlab='Mean Decrease Accuracy')

dev.off()



