uberjohn <- NULL
#Load initial dataset
uberjohn <-  read.csv("uber-data-set.csv")
str(uberjohn)

#load libraries needed for managing and plotting data
library(dplyr)
library(scales)
library(ggplot2)
library(lubridate)
library(tidyr)

#Create day variable from ID text
filter(uberjohn, substr(uberjohn$ID,1,3) == "MON")
uberjohn$dayofweek[substr(uberjohn$ID,1,3) == "MON"] <- "Monday"
uberjohn$dayofweek[substr(uberjohn$ID,1,3) == "TUE"] <- "Tuesday"
uberjohn$dayofweek[substr(uberjohn$ID,1,3) == "WED"] <- "Wednesday"
uberjohn$dayofweek[substr(uberjohn$ID,1,3) == "THU"] <- "Thursday"
uberjohn$dayofweek[substr(uberjohn$ID,1,3) == "FRI"] <- "Friday"
uberjohn$dayofweek[substr(uberjohn$ID,1,3) == "SAT"] <- "Saturday"
uberjohn$dayofweek[substr(uberjohn$ID,1,3) == "SUN"] <- "Sunday"

#Check the mean trip times, mileage and earnings
mean(uberjohn$Trip_time_Percent, trim = 0, na.rm = FALSE)
mean(uberjohn$Trip_Mileage_Percent, trim = 0, na.rm = FALSE)
mean(uberjohn$Earnings_Per_Hour, trim = 0, na.rm = FALSE)

percent(mean(uberjohn$Trip_time_Percent, trim = 0, na.rm = FALSE))
percent(mean(uberjohn$Trip_Mileage_Percent, trim = 0, na.rm = FALSE))

# Plot Trip Time Percent. 
uberjohn$Trip_Date_Full <- as.Date(uberjohn$Trip_Date, "%m/%d")


#Plot the time efficiency variables
p1 <- ggplot(uberjohn, aes(y = Trip_time_Percent, x = Trip_Date_Full, size = Work_Time_converted)) + geom_point(shape = 1)
p1 <- p1 + labs(title = "Trip Time Efficiency", x = "Dates", y = "Trip % of Drive Time") + geom_hline(yintercept = mean(uberjohn$Trip_time_Percent))
p1 <- p1 + annotate("text", y = 0.25, x = mdy("5/05/2016"), label = paste("Mean: ", percent(mean(uberjohn$Trip_time_Percent, trim = 0, na.rm = FALSE)))) + annotate("rect", xmin = mdy("4/26/2016"), xmax = mdy("5/14/2016"), ymin = 0.22, ymax = 0.27, alpha = .2)
p1 <- p1 + geom_smooth(aes(weight = Work_Time_converted), show.legend = FALSE) + scale_y_continuous(labels = percent)
p1 <- p1 + scale_size_continuous(breaks = c(3,6,9,12))
p1

#Plot the mileage efficiency variables.
p2 <- ggplot(uberjohn, aes(y = Trip_Mileage_Percent, x = Trip_Date_Full)) + geom_point(shape = 1)
p2 <- p2 + labs(title = "Trip Mileage Efficiency", x = "Dates", y = "Trip % of Miles Driven") + geom_hline(yintercept = mean(uberjohn$Trip_Mileage_Percent))
p2 <- p2 + annotate("text", y = 0.3, x = mdy("5/05/2016"), label = paste("Mean: ", percent(mean(uberjohn$Trip_Mileage_Percent, trim = 0, na.rm = FALSE)))) + annotate("rect", xmin = mdy("4/26/2016"), xmax = mdy("5/14/2016"), ymin = 0.27, ymax = 0.32, alpha = .2)
p2 <- p2 + geom_smooth(aes(weight = Total_Miles), show.legend = FALSE) + scale_y_continuous(labels = percent)
p2 <- p2 + scale_size_continuous(breaks = c(3,6,9,12))
p2

#Plot earnings efficiency.
uberjohn$cor_eph <- uberjohn$Total_Payment / uberjohn$Work_Time_converted
uberjohn$cor_eph
p3 <- ggplot(uberjohn, aes(y = cor_eph, x = Trip_Date_Full)) + geom_point()
p3 <- p3 + labs(title = "Earnings Efficiency", x = "Dates", y = "Earnings Per Hour") + geom_hline(yintercept = mean(cor_eph))
p3 <- p3 + annotate("text", y = 6, x = mdy("5/05/2016"), label = paste("Mean: ", format(mean(cor_eph), digits = 4))) + annotate("rect", xmin = mdy("4/26/2016"), xmax = mdy("5/14/2016"), ymin = 4, ymax = 7, alpha = .2)
p3 <- p3 + geom_smooth()
p3

#Calculate the Earnings per hour
uberjohn$Earnings_Per_Hour <- NULL
uberjohn$Earnings_Per_Hour <- uberjohn$Total_Payment / uberjohn$Work_Time_converted
str(uberjohn$Earnings_Per_Hour)
 
#Set variables for a new data frame for grouping payment by day of the week
eph <- uberjohn$Earnings_Per_Hour
fare <- uberjohn$Fare
payment <-uberjohn$Total_Payment
dow <- uberjohn$day
ttp <- uberjohn$Trip_time_Percent
tmp <- uberjohn$Trip_Mileage_Percent

#Create the dataframe associating earnings with days of the week.
df_paybyday <- data.frame(dow, fare, payment, eph, ttp, tmp)
str(df_paybyday$ttp)

#Boxplot Hourly Earnings by days of the week
df_paybyday$dow <- ordered(df_paybyday$dow, c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
p4 <- ggplot(df_paybyday) +  geom_boxplot(aes(x = dow, y = eph))
p4 <- p4 + labs(title = "Hourly Earnings by Days of the Week", x = "Days", y = "Earnings Per Hour")
p4

#Boxplot Trip Time Percentage by days of the week
df_paybyday$dow <- ordered(df_paybyday$dow, c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
p5 <- ggplot(df_paybyday) +  geom_boxplot(aes(x = dow, y = ttp))
p5 <- p5 + labs(title = "Trip Times Percent by Days of the Week", x = "Days", y = "Trip Times Percent")
p5 <- p5 + scale_y_continuous(labels = percent)
p5

#Boxplot Trip Mileage by days of the week
df_paybyday$dow <- ordered(df_paybyday$dow, c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
p6 <- ggplot(df_paybyday) +  geom_boxplot(aes(x = dow, y = tmp))
p6 <- p6 + labs(title = "Trip Mileage Percent by Days of the Week", x = "Days", y = "Trip Mileage Percent")
p6 <- p6 + scale_y_continuous(labels = percent)
p6
ub
#Create copy from uberjohn dataframe.
uberjohn2 <- data.frame(uberjohn)

#Output dataframes to csv files
write.csv(uberjohn, "uber_finished_data.csv")
write.csv(df_paybyday, "uber_paybyday_finished.csv")

