# install.packages("googleAuthR")
# install.packages("googleAnalyticsR")
# install.packages("ggplot2")

library("googleAuthR")
library("googleAnalyticsR")
library("ggplot2")
## authenticate, or use the RStudio Addin "Google API Auth" with analytics scopes set
ga_auth()

## get your accounts
account_list <- ga_account_list()
account_list$viewId
ga_id <- 150383599

temp_ga_data = google_analytics_4(ga_id, 
                   date_range = c("2017-02-22", "2017-05-22"), 
                   metrics = c("sessions"), 
                   dimensions = c("date"))

temp_ga_data$sessions = c(191,200,165,134,167,150,122,205,160,80,120,95,29,135,139,137,140,368,255,350,459,340,250,501,453,240,351,600,617,719,500,329,105,542,156,256,350,604,468,430,858,1044,951,1165,870,1045,1305,1045,869,936,1135,1204,1100,1167,1051,975,1000,1064,968,1104,1200,1001,987,870,1045,1056,1201,870,925,1259,806,1305,1051,977,1034,1255,1212,1176,809,1060,1105,1104,801,965,1034,864,1050,1022,1050,1360)

ggplot(temp_ga_data, aes(date, sessions)) + geom_line() + xlab("Month") + ylab("Daily Views")



