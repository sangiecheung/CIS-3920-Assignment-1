#Section 1
getwd()
setwd("C:/Users/Honors/Desktop")
data2014 = read.csv("2014.csv")
data2015 = read.csv("2015.csv")
data2016 = read.csv("2016.csv")
features = c("id","sale","units","rating","product",
             "industry","country","return.client") 
data2014 = data2014[,features]
data2015 = data2015[,features]
data2016 = data2016[,features]
data = rbind(data2014,data2015,data2016)

#Section 2
str(data) #1673 observations and 8 variables
data$product = as.factor(data$product)
data$industry = as.factor(data$industry)
data$country = as.factor(data$country)
data$return.client = as.factor(data$return.client)
str (data)

#Section 3
levels(data$country)
data$country = as.character(data$country)
data$country[data$country=="Switzerland, Switzerland"] = "Switzerland"
countries_to_keep = c("Switzerland","United States","United Kingdom")
data$country[!(data$country %in% countries_to_keep)] = "other"
data$country = as.factor(data$country)
levels(data$country)

levels(data$industry)
sum(is.na(data$industry))
data$industry[data$industry=="999"] = NA 
sum(is.na(data$industry))

#Section 4
for (i in names(data)) {
  print(paste(i,":",sum(is.na(data[i])),sep=" "))
}

data$product[is.na(data$product)==TRUE] = "Delta" 
sum(is.na(data$product))

data = na.omit(data)
sum(is.na(data))
str(data)  #1626 observations remain

#Section 5
data$sale_per_unit = data$sale/data$units
summary(data$sale_per_unit)

data$rating_level = data$rating
data$rating_level[data$rating_level>=5] = "excellent"
data$rating_level[data$rating_level<5 & data$rating_level>4] = "satisfactory"
data$rating_level[data$rating_level<=4] = "poor"
data$rating_level = as.factor(data$rating_level)
levels(data$rating_level)

data$priority = 0
data$priority[data$return.client==1 & data$rating_level=="poor"] = 1
data$priority = as.factor(data$priority)

str(data)
write.csv(data,"cheung_sangie.csv",row.names=FALSE)
