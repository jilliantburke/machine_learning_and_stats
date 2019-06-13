import pandas as pd
import numpy
from sklearn.ensemble import ExtraTreesClassifier
from sklearn.ensemble import RandomForestClassifier

# load data
df = pd.read_csv('Absenteeism_at_work.csv',
                 header=0, sep=',',encoding='utf-8')

# drops the empty line at file-end
df.dropna(how="all", inplace=True) 

#removes the variable "year" from the data (this was added after this script was made and not needed for the remaining analysis)
df=df.ix[:,0:21] 



#create a categorical variable at the end of the dataframe:
# 0-40 hours (less than or equal to 5 work days) missed in a year = low
# 41-80 (5+ to 10 work days) missed in a year = moderate
# 81-120 (10+ to 15 work days) missed in a year = high 
#
def label_category (row):
    if row['Absenteeism time in hours'] <41 :
      return 1
    if row['Absenteeism time in hours'] >40 and row['Absenteeism time in hours'] <81 :
      return 2
    if row['Absenteeism time in hours'] >80:
      return 3

df['category']=df.apply (lambda row: label_category (row),axis=1)

#split the data into the predictors (X) and the outcome (Y), where y is the category define about 
X = df.ix[:,1:20].values
Y = df.ix[:,21].values

#ranks the variables according to feature importance
model = ExtraTreesClassifier()
model.fit(X, Y)
importances=model.feature_importances_

# Make a list of (feature, importance) tuples and sort them in descencing order
features=list(df)[1:20]
pairs = [(features[i], importances[i]) for i in range(len(features))]
pairs_dos=sorted(pairs, key=lambda tup: tup[1], reverse=True) 
print(pairs_dos)



#so simply split the data in 2007 & 2008 for training and 2009 & 2010 for testing

df_train=df.ix[0:358,:]
x_train=df_train.ix[:,1:20]
y_train=df_train.ix[:,21:22]

df_test=df.ix[359:736,:]
x_test=df_test.ix[:,1:20]
y_test=df_test.ix[:,21:22]


#creates and tests a random forest classifier
regressor = RandomForestClassifier(n_estimators=10, max_features=14, random_state=0)  
regressor.fit(x_train, y_train)  
y_pred = regressor.predict(x_test)
y_pred=[round(val) for val in y_pred]
from sklearn.metrics import classification_report, confusion_matrix, accuracy_score
print(confusion_matrix(y_test,y_pred))  
print(classification_report(y_test,y_pred))  
print(accuracy_score(y_test, y_pred))
