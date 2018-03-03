
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
temp_ga_data_userType = google_analytics_4(ga_id, date_range = c("2017-04-14", "2017-06-18"),  metrics = c("ga:sessions"),dimensions = c("ga:sessionCount"))

# using example file
temp_ga_data_userType = read.csv("ExampleFile_1.4_FrequencyRecency.csv", sep=",", header=T)



# making sure our axis show up correctly
CountOfSessions = rev(temp_ga_data_userType$Count.of.Sessions)
temp_ga_data_userType$Count.of.Sessions =  factor(temp_ga_data_userType$Count.of.Sessions, levels = CountOfSessions)


temp_ga_data_userType$Users = as.numeric(gsub(",", "", temp_ga_data_userType$Users))
temp_ga_data_userType$Pageviews = as.numeric(gsub(",", "", temp_ga_data_userType$Pageviews))

# calculate percentage
temp_ga_data_userType$UsersPercentage = temp_ga_data_userType$Users / sum(temp_ga_data_userType$Users)
temp_ga_data_userType$PageviewsPercentage = temp_ga_data_userType$Pageviews / sum(temp_ga_data_userType$Pageviews)



theme_set(theme_bw())

# Draw plot
ggplot(temp_ga_data_userType, aes(x=Count.of.Sessions, y=Users)) + 
  geom_bar(stat="identity", width=.8, fill="tomato3") + coord_flip()  +  geom_text(aes(y = Users, label = percent(UsersPercentage)),  hjust = -0.1)+ scale_y_continuous(breaks = seq(0,110000,20000),limits = c(0,110000),labels = comma) + ylab("Number of Sessions") + xlab("Number of Users") + 

 labs(title="Returning Visitor Rate (RVR) Plot", 
       subtitle="Number of Sessions per User") + 
  theme(axis.text.x = element_text(angle=45, vjust=0.6)) 
  
  
  
