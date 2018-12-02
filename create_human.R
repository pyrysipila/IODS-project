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


#### RStudio Exercise 5, data wrangling

?read.table
human <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt" , sep = "," , header = T)
head(human)
names(human)
str(human)
dim(human)
summary(human)

# Original data from: http://hdr.undp.org/en/content/human-development-index-hdi

# The data are from the United Nations Development Programme. They describe most countries in the world.

#The variables are:

# HDI = Human.Development.Index..HDI.
# Life.Exp = Life.Expectancy.at.Birth
# Edu.Exp = Expected.Years.of.Education
# Edu.Mean = Mean.Years.of.Education
# GNI = Gross.National.Income..GNI..per.Capita
# GNI.Minus.Rank = GNI.per.Capita.Rank.Minus.HDI.Rank

# GII = Gender.Inequality.Index..GII.
# GII.Rank = Rank of Gii
# Mat.Mor = Maternal.Mortality.Ratio
# Ado.Birth = Adolescent.Birth.Rate
# Parli.F = Percent.Representation.in.Parliament
# Edu2.F = Population.with.Secondary.Education..Female.
# Edu2.M = Population.with.Secondary.Education..Male.
# Edu2.FM = Female to male ratio in the proportion of populaiton with secondary education
# Labo.F = Labour.Force.Participation.Rate..Female.
# Labo.M = Labour.Force.Participation.Rate..Male.

#1
library(stringr)
str_replace(human$GNI, pattern=",", replace ="")
human <- mutate(human, GNI = as.numeric(GNI))

#2
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human,one_of(keep))

#3
# filter out all rows with NA values
human <- filter(human, complete.cases(human) == TRUE)

#4
human$Country

# look at the last 10 observations of human
tail(human, n=10)

# define the last indice we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human_ <- human[1:last, ]

# add countries as rownames
rownames(human_) <- human_$Country

#5

# remove the Country variable
human_ <- select(human, -Country)

write.csv(human, file="//atkk/home/p/pyrysipi/Documents/Tutkimus/Kurssit/Introduction to Open Data Science 2018/Data/human.csv",row.names = TRUE)
