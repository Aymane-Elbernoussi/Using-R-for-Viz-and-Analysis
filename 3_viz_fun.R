#Libraries that I may need 
library(lattice)
library(ggplot2)
library(dplyr)
library(data.table)


#Load my data of Cyber Security Breaches of various types found on https://vincentarelbundock.github.io/Rdatasets/datasets.html
data <- read.csv("breaches.csv")

#deleting irrelevant columns manually (eep)
data <- data[,-1:-5]
data <- data[,-4:-8]
data <- data[,-2]

# Filtering only Theft breaches, this is what I personally chose to visualize 
data <- filter(data, Type_of_Breach == "Theft")

# aggergating the data to show the sum of all Theft Breaches by year 
# using this we bring all instances (breaches) into one row and gives us a much more robust data frame to visualize 
data<- with(data, aggregate(list(Individuals_Affected = Individuals_Affected), list(year = tolower(year)), sum))

#Using a base R plot function 

# I add a divided by 365 to give us an idea of how many theft breaches are occuring on a daily average scale
plot(data$year,data$Individuals_Affected/365,
     type = "b",
     pch = 21,
     bg = "red",
     col = "black",
     lwd = 2,
     xlab = "Year",
     las = 3,
     log = "y",
     ylab = "AVG # of Theft Breaches Per Day",
     main = "Theft Breaches Over The Years")

# now lets try to visualize using paul's lattice package 
barchart(data$year ~ data$Individuals_Affected/365, data = data,
         main = "Theft Breaches Over The Years",
         xlab = "Year",
         ylab = "AVG # of Theft Breaches Per Day")

# now lets use some ggplot2 action

ggplot(data, aes(x=year, y=Individuals_Affected/365)) +
  geom_point(size=2, shape=10) +
labs(title="Theft Breaches Over The Years",
     x="Year", y = "AVG # of Theft Breaches Per Day")+
  theme_classic()  
