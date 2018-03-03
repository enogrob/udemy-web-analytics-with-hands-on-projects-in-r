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
ga_data = google_analytics_4(ga_id, date_range = c("2017-06-11", "2017-06-18"), metrics = c("ga:exitRate","ga:pageviews", "ga:bounceRate"), dimensions = c("ga:pagePath"))



# https://support.google.com/analytics/answer/1009409?hl=en
# how the bounce rate is calculated

ga_data = read.csv("ExampleFile_1.5_ViewPages_File1.csv", sep=",", header=T)
ga_data.toPlot = data.frame(ga_data)

# setting the page correctly
ga_data.toPlot$Page = factor(ga_data.toPlot$Page, levels = rev(ga_data.toPlot$Page))
# ggplot
# table




# theme_set(theme_bw())
# my.plot = ggplot(ga_data.toPlot, aes(x=Page, y=Bounce.Rate, fill= Bounce.Rate < 0.5)) + geom_bar(stat="identity", width=.8, show.legend = FALSE) + coord_flip()  + ylim(0, 1.0) +geom_text(aes(y = Bounce.Rate, label = percent(Bounce.Rate)),  hjust = -0.1) + 
#   geom_hline(yintercept = 0.5,linetype="dashed" ) + ylab("Bounce Rate") + xlab("Page Path") 


bounce.Rate.Plot = ggplot(ga_data.toPlot, aes(x=Page, y=Bounce.Rate)) + geom_bar(fill="cornflowerblue",stat="identity", width=.8, show.legend = FALSE) + coord_flip()  + ylim(0, 1.0) +geom_text(aes(y = Bounce.Rate, label = percent(Bounce.Rate)),  hjust = -0.1) + 
  geom_hline(yintercept = 0.5,linetype="dashed" ) + ylab("Bounce Rate") + xlab("Page Path") 
bounce.Rate.Plot




exit.Rate.Plot = ggplot(ga_data.toPlot, aes(x=Page, y=Exit.Rate)) + geom_bar(fill="tomato3",stat="identity", width=.8, show.legend = FALSE) + coord_flip()  + ylim(0, 1.0) +geom_text(aes(y = Exit.Rate, label = percent(Exit.Rate)),  hjust = -0.1) + 
  geom_hline(yintercept = 0.5,linetype="dashed" ) + ylab("Exit Rate") + xlab("Page Path") 





