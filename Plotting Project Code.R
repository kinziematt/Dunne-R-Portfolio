##set working directory
setwd("C:/Users/uawe/Desktop/Coursera/Data Science Specialization/Course 4 Exploratory Data Analysis/Course Projects/Project 2")
## read in emissions data
NEI<-readRDS("summarySCC_PM25.rds")
## read in source class code table
SCC<-readRDS("Source_Classification_Code.rds")

##subset to Baltimore City data
balt<-subset(NEI, fips=="24510")
##run tapply indexing by year and type on the sum of emissions
three<-with(balt, tapply(Emissions, list(year, type), sum, na.rm=TRUE))
## convert to data frame
data3<-data.frame(three)
## create tranpose of data so years are columns (easier to work with in rearranging)
data3<-t(data3)
##create separate data frames for each year
df1<-data.frame(Total=data3[,1], type=c("Non-Road", "Non-Point", "On Road", "Point"), year=1999)
df2<-data.frame(Total=data3[,2], type=c("Non-Road", "Non-Point", "On Road", "Point"), year=2002)
df3<-data.frame(Total=data3[,3], type=c("Non-Road", "Non-Point", "On Road", "Point"), year=2005)
df4<-data.frame(Total=data3[,4], type=c("Non-Road", "Non-Point", "On Road", "Point"), year=2008)
##merge into one data frame
data<-rbind(df1, df2, df3, df4)
row.names(data)<-NULL
## open graphics file
png(file="plot3.png")
library(ggplot2)
## set up plot with year on x-axis, Total emissions on y-axis
g<-ggplot(data, aes(year, Total))
##line plot differentiated by type. X-axis modified. Re-labelled
g+geom_line(aes(color=type), size=2)+scale_x_continuous(breaks = c(1999, 2002, 2005, 2008), label=c("1999", "2002", "2005", "2008"))+labs(title="Total Emissions in Baltimore by Source Type", x="Year", y="Total Emissions")
##close graphics device
dev.off()


