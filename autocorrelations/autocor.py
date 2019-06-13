import pandas as pd

#open data
df = pd.read_csv('Absenteeism_at_work.csv',
                 header=0, sep=',',encoding='utf-8')

df.dropna(how="all", inplace=True) # drops the empty line at file-end

#### make a new date variable
def label_month_year(row):
   return(str(row['Month of absence'])+str(row['Year']))
df['month-year']=df.apply(lambda row: label_month_year (row),axis=1)

#and sum all of the values for each month
df2=df.groupby('month-year').sum()[['Absenteeism time in hours']]
df2['Date']=pd.to_datetime(df2.ix[:,0].keys(), format='%m%Y')
df2=df2.sort_values(by='Date')

# plots
from matplotlib import pyplot
from statsmodels.graphics.tsaplots import plot_acf
time1=pd.Series(df2['Absenteeism time in hours'].values, index=df2['Date'])

# simple line plot
plot=time1.plot() 


#autocorrelation plot - comment out the first plot and run the line below to get autocorrelation plot
#plot2=plot_acf(time1) 

pyplot.show()
