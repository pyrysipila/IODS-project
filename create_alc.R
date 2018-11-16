#Pyry Sipilä
#16.11.2018
#Data wrangling excercise of "Introduction to Open Data Science 2018" MOOC part 3 "Logistic regression"

#datasource: https://archive.ics.uci.edu/ml/datasets/Student+Performance

# read the data
math <- read.csv("//atkk/home/p/pyrysipi/Documents/Tutkimus/Kurssit/Introduction to Open Data Science 2018/Data/student-mat.csv", sep=";")
por <- read.csv("//atkk/home/p/pyrysipi/Documents/Tutkimus/Kurssit/Introduction to Open Data Science 2018/Data/student-por.csv", sep=";")
  
#dimensions of the data (rows and columns)
dim(math)
dim(por)
#both data have 33 variables but they have different amounts of observations (395 in math and 649 in por)

#structure of the data
str(math)
str(por)

# explore the first rows of the data
head(math)
head(por)

#summarize each variable in the data
summary(math)
summary(por)

# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers (keep only the subjects who are present in both datasets)
math_por <- inner_join(math, por, by = join_by , suffix=c(".math",".por"))

# see the new column names
colnames(math_por)

# glimpse at the data
glimpse(math_por)

#explore the structure and dimensions of the data
str(math_por)
dim(math_por)
#there are 382 observations and 53 variables



#### combine the duplicated answers ####

# print out the column names of 'math_por'
colnames(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns
colnames(alc)
# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

# define a new column alc_use by combining weekday and weekend alcohol use by taking the average of them
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

#Glimpse at the joined and modified data to make sure everything is in order
glimpse(alc)

# Save the joined and modified data set to the 'data' folder
write.csv(alc, file="//atkk/home/p/pyrysipi/Documents/Tutkimus/Kurssit/Introduction to Open Data Science 2018/Data/alc.csv",row.names = FALSE)
