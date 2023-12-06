#install libraries  :
install.packages("ggplot2",dependencies=TRUE, repos='http://cran.rstudio.com/')
install.packages("GGally",dependencies=TRUE, repos='http://cran.rstudio.com/')
install.packages("MASS",dependencies=TRUE, repos='http://cran.rstudio.com/')
install.packages("corrplot",dependencies=TRUE, repos='http://cran.rstudio.com/')
install.packages("caret",dependencies=TRUE, repos='http://cran.rstudio.com/')
install.packages("vegan",dependencies=TRUE, repos='http://cran.rstudio.com/')
 #import libraries 
library(ggplot2)
library(GGally)
library(MASS)
library(corrplot)
library(caret)
library(vegan)
#import data 
data(iris)
head(iris) 
str(iris)

#Descriptive Statistics:

describeBy(iris$Sepal.Length, iris$Species) 
describeBy(iris$Sepal.Width, iris$Species)
describeBy(iris$Petal.Length, iris$Species)
describeBy(iris$Petal.Width, iris$Species)

#scatter plot matrices
my_cols <- c("#00AFBB", "#E7B800", "#FC4E07")  
pairs(iris[,1:4], pch = 19,  cex = 0.5,  main = "Relation entre les variable de données iris ", 
 col = my_cols[iris$Species])

 
#boxplot
ggplot(data = iris) +
  aes(x = Species, y = Sepal.Length, color = Species) +
  geom_boxplot()

  ggplot(data = iris) +
    aes(x = Species, y = Sepal.Width, color = Species) +
  geom_boxplot()

  ggplot(data = iris) +
      aes(x = Species, y =  Petal.Length, color = Species) +
  geom_boxplot()

  ggplot(data = iris) +
        aes(x = Species, y = Petal.Width, color = Species) +
  geom_boxplot()

#corellation 
cr <- cor(iris[1:4])
corrplot(cr,method="pie")


# scale 
iris[1:4] <- scale(iris[1:4])

apply(iris[1:4], 2, mean)
apply(iris[1:4], 2, sd)

#chek the NA value 
any(is.na(iris))

#train + test sampeles 
set.seed(1)
sample <- sample(c(TRUE, FALSE), nrow(iris), replace=TRUE, prob=c(0.9,0.1))
train <- iris[sample, ]
test <- iris[!sample, ] 
head(train)
head(test)


model <- lda(Species~., data=train)
model

#make preddiction 

predicted <- predict(model, test)
head(predicted$class)
predicted$posterior
head(predicted$x)

fit.LDA.C = predict(model, newdata=iris[,1:4])$class
fit.LDA.C

table(iris[,5],fit.LDA.C)


#VISUALIZE LINEAR DISCRIMINANTS
lda_plot <- cbind(train, predict(model)$x)
ggplot(lda_plot, aes(LD1, LD2)) +
  geom_point(aes(color = Species))



