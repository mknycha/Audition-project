EAdata <- read.csv("D:/Nauka/R/Pearson zadanie/Audition project/EA_audition_for_sharing/data.csv")
##Checking the data
View(EAdata)
summary(EAdata)
nrow(EAdata)
nrow( na.omit(EAdata) )
for (x in 1:length(EAdata)) {
  print( class(EAdata[,x])  )
}
dup<-duplicated(EAdata)
summary(dup) #No duplicates!

##Little check, if there are any rows where learner with particular id has more than one country assigned
ids<-unique(EAdata[,1]) 
for (x in ids) {
  tmp<-unique(EAdata[EAdata$learner_id==x,2])
  if (length(tmp)!=1) {
    print(EAdata[EAdata$learner_id==x,])
  }
}
#Checking correlations for different variables
EAdata.3.5<-na.omit(EAdata[,c(3,5)])
cor(as.numeric(EAdata.3.5[,1]),EAdata.3.5[,2])

EAdata.5.7<-na.omit(EAdata[,c(5,7)])
cor(as.numeric(EAdata.5.7[,1]),EAdata.5.7[,2])

EAdata.4.5<-na.omit(EAdata[,c(4,5)])
cor(as.numeric(EAdata.4.5[,1]),EAdata.4.5[,2])

#Looks like there is no statisticaly relevant colinearity between avg_score and the variables - inv_rate,unit & in_course

##Looking for different models
model <- lm(formula = avg_score ~ as.numeric(in_course) + inv_rate + as.numeric(country), 
            data = EAdata)
modelStep <- step(lm(formula = avg_score ~ ., data = EAdata[,-1]))
model <- lm(formula = avg_score ~ in_course,  data = EAdata)
plot(EAdata$country,EAdata$avg_score)
#None of the models looked useful. 

##Calculating mean for of avg_score for each country
library(dplyr)
meanScores<- EAdata %>%
  group_by(country) %>%
  summarise_each(funs(mean(., na.rm=TRUE)), avg_score)
##Let's add to this data frame column with number of student
studentsCountries <- as.data.frame( table(EAdata$country) )
meanScores <- cbind(meanScores, studentsNumber=studentsCountries$Freq)

##Small ranking of mean scores in each country (only those with more than 50 students)
df_meanScores <- as.data.frame(meanScores[meanScores$studentsNumber>50,])
df_meanScores = df_meanScores[ order(df_meanScores$avg_score), ]
head(df_meanScores) #Great Britian the worst
tail(df_meanScores) #Ukraine turned out to have the best mean score from the filtered ones
##Filtering the 5 countries with highest number of student
selCountries1000 <- meanScores[meanScores$studentsNumber>1000,1]
EAdataFiltered <- EAdata[EAdata$country == selCountries1000,]
##Presenting the 5 countries with highest number of student on a plot
plt<-barplot(table(EAdataFiltered$in_course,as.character( EAdataFiltered$country) ),beside = TRUE, col=c("red","yellow"))
legend("topleft", c("studying alone","studying in course"), lwd=10, col=c("red","yellow"))
tab<-table(EAdataFiltered$in_course,as.character( EAdataFiltered$country) )


##Filtering countries for mean analysis (ANOVA) based on number of observations (taking only five countries with highest number of observations)
testMean <- aov(avg_score~country, data = EAdataFiltered)
summary(testMean)
#It looks like mean scores are different for at least one pair of countries
hsdResult<-TukeyHSD(testMean) #Comparing mean score for each of 5 countries with highest number of students.
#All the tested pairs of countries has significantly different mean score from each other, except of IT-ES.
#Could it be, that level of education differs in all these countries?

##Does the average score differ between students studying in group, and studying alone?
k<-cut(EAdata$avg_score,breaks = 10)
table(EAdata$in_course,k)

selCountries50 <- meanScores[meanScores$studentsNumber>50,1]
EAdataFilteredSmall <- EAdata[EAdata$country == selCountries50,]
testMean <- aov(avg_score~in_course, data = EAdataFilteredSmall)
summary(testMean)
summary(EAdataFilteredSmall[EAdataFilteredSmall$in_course=="t",5])
summary(EAdataFilteredSmall[EAdataFilteredSmall$in_course=="f",5])

##Mean score for all the students
totalMean<-mean(EAdata$avg_score, na.rm = TRUE)
compMeanData<-EAdata[EAdata$avg_score>totalMean,]
length(unique( compMeanData$learner_id ))
length(unique( EAdata$learner_id ))
print(totalMean)
median(EAdata$avg_score, na.rm = TRUE)
hist(EAdata$avg_score) #The distribution is negatively skewed

