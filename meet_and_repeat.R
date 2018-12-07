#RStudio Exercise 6
#Pyry Sipilä

#1
# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
colnames(BPRS)
str(BPRS)
dim(BPRS)
summary(BPRS)

# Read the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')
colnames(RATS)
str(RATS)
dim(RATS)
summary(RATS)

#2
# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#3
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
glimpse(BPRSL)

RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group)

#4
# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
glimpse(BPRSL)

#Ad a time variable to RATS
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

#5
names(BPRS)
names(BPRSL)
str(BPRS)
str(BPRSL)
BPRS
BPRSL
summary(BPRS)
summary(BPRSL)

names(RATS)
names(RATSL)
str(RATS)
str(RATSL)
RATS
RATSL
summary(RATS)
summary(RATSL)
