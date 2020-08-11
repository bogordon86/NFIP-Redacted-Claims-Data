#Load Dependencies
#install.packages("SparkR")
library(SparkR)



#initiate Session
#sparkR.session()
sparkR.session(master = "local[*]", sparkConfig = list(spark.driver.memory = "64g"))



#Set working directory where files located
nfipdir <- choose.dir()

#Read in NFIP claims files
clm <- read.df(paste(nfipdir, "openFEMA_claims20190831.csv", sep ="\\"),
               "csv", header = 'true')

#Explore data
head(clm)


#Filter by state
clmfiveyr <- filter(clm, clm$yearofloss > "2015")

#Explore filtered data
head(clmfiveyr)


#Enter the results into an R dataframe (Typically run into "OutofMemory" error)
colclmfiveyr <- collect(clmfiveyr)

head(colclmfiveyr)

#write output to directory on computer 
write.csv(colclmfiveyr, 'C:/Users/gordo/Desktop/nfip_claims_five_year.csv', na = "", row.names = FALSE)
