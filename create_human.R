#Pyry Sipilä

#2 Read the data

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#3 Explore the datasets

str(hd)
str(gii)
dim(hd)
dim(gii)

# Summaries of variables
summary(hd)
summary(gii)

#4 Look at the meta files and rename the variables
as.data.frame(hd)
as.data.frame(gii)
library(dplyr)
hd <- rename(hd,HDI=Human.Development.Index..HDI.)
hd <- rename(hd,life_expectancy=Life.Expectancy.at.Birth)
hd <- rename(hd,expected_education=Expected.Years.of.Education)
hd <- rename(hd,mean_education=Mean.Years.of.Education)
hd <- rename(hd,mean_education=Mean.Years.of.Education)
hd <- rename(hd,GNI_per_capita=Gross.National.Income..GNI..per.Capita)
hd <- rename(hd,GNI_minus_HDI_rank=GNI.per.Capita.Rank.Minus.HDI.Rank)

gii <- rename(gii,GII=Gender.Inequality.Index..GII.)
gii <- rename(gii,MMR=Maternal.Mortality.Ratio)
gii <- rename(gii,ABR=Adolescent.Birth.Rate)
gii <- rename(gii,parliament_women=Percent.Representation.in.Parliament)
gii <- rename(gii,educated_women=Population.with.Secondary.Education..Female.)
gii <- rename(gii,educated_men=Population.with.Secondary.Education..Male.)
gii <- rename(gii,at_work_women=Labour.Force.Participation.Rate..Female.)
gii <- rename(gii,at_work_men=Labour.Force.Participation.Rate..Male.)

summary(hd)
summary(gii)

#5 Mutate the "Gender inequality" data
gii <- mutate(gii,educated_ratio=educated_women/educated_men)
gii <- mutate(gii,at_work_ratio=at_work_women/at_work_men)

#6 Join together the two datasets
human <- inner_join(hd, gii, by="Country")
glimpse(human)

write.csv(human, file="//atkk/home/p/pyrysipi/Documents/Tutkimus/Kurssit/Introduction to Open Data Science 2018/Data/human.csv",row.names = FALSE)
