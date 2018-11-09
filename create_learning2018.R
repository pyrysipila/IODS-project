# Pyry Sipilä
# 6.11.2018
# Practical of IODS day 2

# read the data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header=T, sep="\t")

#dimensions of the data (rows and columns)
dim(df)

#structure of the data
str(df)

# explore the first rows of the data
head(df)

#summarize each variable in the data
summary(df)

#activate dplyr library
library(dplyr)
#learn how to use dplyrs select
?select

#rescale attitude
lrn14$attitude <- df$Attitude / 10

#pick the right questions
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

#pick the right columns and create a new variable out of them 
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

#pick the right columns and create a new variable out of them
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

#pick the right columns and create a new variable out of them
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

#create analysis variable dataset
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14,one_of(keep_columns))

#exclude observations where points=0
learning2014 <- filter(learning2014,Points!=0)
dim(learning2014)

#wranglin part 4
setwd("//atkk/home/p/pyrysipi/Documents/Tutkimus/Kurssit/Introduction to Open Data Science 2018")
?write.csv
write.csv(learning2014, file="//atkk/home/p/pyrysipi/Documents/Tutkimus/Kurssit/Introduction to Open Data Science 2018/Data/learning2014.csv",row.names = FALSE)
learning2014 <- read.csv("//atkk/home/p/pyrysipi/Documents/Tutkimus/Kurssit/Introduction to Open Data Science 2018/Data/learning2014.csv")
head(learning2014)
str(learning2014)
