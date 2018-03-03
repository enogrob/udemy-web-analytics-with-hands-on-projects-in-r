library("googleAuthR")
library("googleAnalyticsR")
library("ggplot2")
#install.packages("scales")
library("scales")

## authenticate, or use the RStudio Addin "Google API Auth" with analytics scopes set
ga_auth()

## get your accounts
account_list <- ga_account_list()
account_list$viewId
ga_id <- 152486052

# downloading Google API
ga_data = google_analytics_4(ga_id, date_range = c("2017-04-14", "2017-06-14"), metrics = c("ga:sessions"), dimensions = c("ga:userType"))

# using example file
ga_data = read.csv("ExampleFile_1.4_NewvsReturning.csv", sep=",", header=T)

# cleaning up data
ga_data.toPlot = data.frame(userType = c("New Visitor", "Returning Visitor"), sessions=ga_data$Sessions)
ga_data.toPlot$sessions = as.numeric(gsub(",","", ga_data.toPlot$sessions))
ga_data.toPlot$percentage = ga_data.toPlot$sessions/sum(ga_data.toPlot$sessions)

ggplot(ga_data.toPlot, aes(x=userType, y=sessions, fill=userType)) + geom_bar(width=0.6, stat="identity") + geom_text(aes(y=sessions/2, label=percent(percentage)), size=5)