Original data were divided in Test and train data.  
First of all, those data were separately downloaded into R tables: subject, X, and y files for both test and train set of data.
(subject_train, X_train, y_train, subject_test, X_test, y_test)

Then, headers for the X values were extracted from the features.txt file and applied to both test and train datasets.

These headers were used to filter out only means and standard deviations from the set of observations. 
This extraction was done using a regular expression search on the header names with an R function: grepl.

Next, test and train data sets were merged into one. 
For readability column names of SubjectID and Activity were added for the subject and y values respectively.

The modified Test and Train data sets were merged by the aggregate function on all columns of the data frame, grouping by 
SubjectID and Activity and performs the mean. This yielded an appropriate 180 observations (30 subjects * 6 activities) of the
68 variables.

Finally, for clarity an activity name was assigned to each of the levels in the Activity column.

When the script is executed it will output tab separated values to a text file (named tidy_final_data.txt) in the same data folder
where original data were downloaded.
