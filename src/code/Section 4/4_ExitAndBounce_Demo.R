library("googleAuthR")
library("googleAnalyticsR")
library("ggplot2")
library("scales")

## authenticate, or use the RStudio Addin "Google API Auth" with analytics scopes set
ga_auth()

## get your accounts
account_list <- ga_account_list()
account_list$viewId
ga_id <- 152486052

# downloading Google API
# exit
ga_data = google_analytics_4(ga_id, date_range = c("2017-06-11", "2017-06-18"), metrics = c("ga:exitRate", "ga:pageviews","ga:bounceRate"), dimensions = c("ga:pagePath"))


ga_data = read.csv("ExampleFile_1.5_ViewPages.csv", sep=",", header=T)

# turn into data.frame
ga_data.toPlot = data.frame(ga_data)
ga_data.toPlot$Page = factor(ga_data.toPlot$Page, level=rev(ga_data.toPlot$Page))

bounce.Rate.Plot = ggplot(ga_data.toPlot, aes(x=Page,y=Bounce.Rate)) + coord_flip() + geom_bar(fill="cornflowerblue", width=0.8, stat="identity", show.legend = FALSE) + geom_text(aes(y = Bounce.Rate, label = percent(Bounce.Rate)),  hjust = -0.1) + ylim(0,1.0) + geom_hline(yintercept = 0.5, linetype="dashed") + ylab("Bounce Rate") + xlab("Page Path") 



exit.Rate.Plot = ggplot(ga_data.toPlot, aes(x=Page,y=Exit.Rate)) + coord_flip() + geom_bar(fill="tomato3", width=0.8, stat="identity", show.legend = FALSE) + geom_text(aes(y = Exit.Rate, label = percent(Exit.Rate)),  hjust = -0.1) + ylim(0,1.0) + geom_hline(yintercept = 0.5, linetype="dashed") + ylab("Exit Rate") + xlab("Page Path") 
