# Uber Efficiency tet
By John Houlgate
## Introduction
One of the most intriguing aspects of being an Uber rideshare driver is that it affords the driver an opportunity to provide a valuable service, while working intimately with data. As a driver with an interest in data science, I found myself wondering how I might use data science methods and practices to improve my driving efficiency and hopefully earn more money. I’ve been driving on the platform since November of 2014, first as a part-time driver in the suburbs around Portland, OR and then later going full-time when Uber and Lyft were permitted to operate within the city limits. This work involves working with a cloud server and smartphone app system. This system constantly processes data from the time you log in and ‘go-online’ until calling it quits for the day and going home. Uber makes a certain amount of data available to drivers, ostensibly to help them in their work and determine their tax write-offs. I believe this data can also lead to some insights that can aid their performance and decision-making to make more efficient use of their time. As with any exploration, some data can reveal some new insights, stimulate more questions, and hopefully this project will open the door to more possibilities. 
First, a little background is in order. An Uber driver is a self-employed individual who uses Uber’s platform to connect with customers and drive them to where they want to go. The driver logs onto a smartphone app that’s mounted in his car, making himself available for ride requests. The Uber servers receive requests from interested persons, locates the nearest available driver and sends the request to that driver. The driver either accepts or rejects the request. If he chooses the former, his app shows location details where his customer waits for him. The driver goes to the pickup spot, meets the customer-passenger(s), begins the fare and drives to the customer’s destination. At the end of the trip, the driver ends the fare, which is charged automatically to the customer’s account and the two parties go their merry ways. The money exchange functions completely as a cashless, online transaction.
The problem I want to solve is really to answer the questions, how efficient am I?  How can I become more efficient? And how can I use data science to learn more about my driving habits and experience? To answer those questions, I need to come up with definitions of efficiency in this context, then use whatever data I can acquire to analyze and see more clearly what it is telling me. Efficiency here comes in the following areas:
The problem I want to solve is really to answer the questions, how efficient am I?  How can I become more efficient? And how can I use data science to learn more about my driving habits and experience? To answer those questions, I need to come up with definitions of efficiency in this context, then use whatever data I can acquire to analyze and see more clearly what it is telling me. Efficiency here comes in the following areas:

__Time__: - How much time am I spending earning fares in relation to the total time I make myself available to give rides.
__Mileage__: - How many miles am I driving while earning fares relative to the total miles I put on the car when I go out to rideshare.
__Earnings__: - How many dollars am I earning per every hour I am out ridesharing? How much do my daily earnings vary and what causes them to vary.
Are there any correlations between the above three modes of efficiency given above? Are their particular days in which I am earning more efficiently than on other days?
## What important fields and information does the data set have?
The main data set represents information collected over a 90 day period beginning from February 19 through May 11, 2016. Data was collected from three sources:

1.My personal Uber trip history from my logged-in, driver website.
2.Uber invoice records, also from my logged-in, driver website
3.Data I personally entered into a spreadsheet file on my smartphone.

I merged the data into one final dataset. The most imporants fields included the following. They are described as follows:

**Date_Time_From** - The date and time I began my driving shift
**Date_Time_To** - The datae and time I ended my driving shift
**work_time** - The difference between Date_Time_From and Date_Time_To encapsulating my shift hours. 
**Trip_Time** - Time acquired from Uber that marks the time spent on fare producing trips.
**Trip_time_Percent** - Percentage of time spent on trips relative to work_time
**Off-Trip_Time** - The difference between my Work_Time and Trip_Time. This is the time spent on my shift in which I was not on a trip.
**Odometer_From** - Odometer mile reading when I began a shift
**Odometer_To** - Odometer mile reading when I ended a shift
**Total_Miles** - The difference between Odometer_From and Odometer_To marking the total miles driven during a shift.
**Trip_Mileage** - Total miles recorded while on fare trips. This was provided by Uber
**Trip_Mileage_Percent** - Percentage of Trip_Mileage relative to Total_Miles
**Off_Trip_Mileage** - The difference between Total_Miles and Trip_Mileage.
**Total_Payment** - What I was paid from fares during my shifts.
**Work_Time_converted** - Work_Time converted to a decimal number, necessary for calculating Earnings_Per_Hour 
**Earnings_Per_Hour** - How much money I made per hour. The result of Total_Payment divided by Work_Time_converted

## What are its limitations i.e. what are some questions that you cannot answer with this data set?

The data set is limited in to ways:

A)The data covers the hours of the 24 hour cycle that I drove, mostly the night and early morning hours. Since I did very little daytime driving, I am unable to make comparisons between daytime and nighttime driving. 

B) Another problem is that my data set does not include locations, where was I when I received ride requests, where did I pickup the drivers, how far did I have to drive to pick them up and where did I drop them off. Location data would have added another dimension that might be helpful in determining efficiency and also with developing an understanding of predictable patterns. For example, over a period of time, I could determine how likely I would be to get ride requests within a certain locale during certain hours of the day. Uber provides maps of the trips on the driver website, addresses in the trip history on the app, but no geographic coordinates. What location data is available cannot be easily copied and pasted into rows on a spreadsheet, like other data.

## What kind of cleaning and wrangling did you need to do?

The data about my shifts was pretty easy, though tedious, to enter on my spreadsheets. The data provided by Uber required copying and pasting it from the website onto a spreadsheet. Again, the task was easy, though tedious. Ninety days of data about my driving was not too daunting to say the least. 

I had another problem and that was to match up the Uber’s daily observations with my own. Uber provided trip data, which meant every row of data pertained to individual trips. My data was entered by the day or shift. What I had to do was aggregate columns like the trip times, miles and fares to match the daily shifts that I recorded on my own. To illustrate, if I began my shift at 8:00 pm and ended at 6:00 am the next morning I would aggregate the trips that were recorded in that period and assign them to the date of when I began that shift. So my shifts would straddle over two dates, but I had to come up with a guide for determining which date to record trips in a shift that spanned over two dates. It was not impossible, just a little tedious.

## Any preliminary exploration you’ve performed and your initial findings.

My first exploration was to view the means of time, distance and earnings to determine how I should base efficiencies. Any data above the means would be considered greater efficiency and any data below the means would be considered less efficiency. One pleasant surprise was that I found from smoothing along the scatterplots was that over time, my efficiency in all three areas showed general rising.

One area I wanted to check was how efficiency varied from weekdays to weekends. I noticed there was no dramatic difference between them.

## Based on these findings, what approach are you going to take? How has your approach changed from what you initially proposed, if applicable?

My approach is simply to observe three areas of efficiency through scatter plotting and track the distribution across the timeline. I am also using Whisker Plots to look at the data grouped by days of the week and observe the distributions to see how they vary and compare. I’m hoping that these observations reveal something I haven’t noticed before and suggest changes to my driving habits that might yield greater efficiency in all three areas.