from pandas import Series
from matplotlib import pyplot
from statsmodels.graphics.tsaplots import plot_acf

# CSV files were created using Microsoft Excel to partition and order the data set. All files had a time column
# (typically day) and a absenteeism column.
# The strings would change depending on the CSV file to give appropriate names to both the file and the plots.

csv_file = "Summed Months.csv"

# Read in the CSV file.
series = Series.from_csv(csv_file, header=0)

# Plot the CSV file with the time column as the X-axis and the absenteeism column as the Y-axis.
series.plot(title="Summed Months")

# Plot the autocorrelation of the CSV file. Remove zero lag correlation as it was always 1.
plot_acf(series, title="Summed Months Autocorrelation", zero=False)

# Display plots.
pyplot.show()
