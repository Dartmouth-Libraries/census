
# install.packages("foreign")
library(foreign)
library(dplyr)
library(tidyverse)
library(tidyr)
library(tidycensus)


# install.packages("readr")
library(readr)
# install.packages("censusapi")
# library(censusapi)

setwd("C:/Users/F0040RP/Documents/DartLib_RDS/censusData/popdata/ICPSR_02896")

#ICPSR DATA DOWNLOADED FROM ICPSR (NEED TO REGISTER FOR AN ACCOUNT)
## DOWNLOADED FROM ICPSR PROJECT 02896 as .spss files 
## (PERHAPS WOULD HAVE MADE MORE SENSE TO DOWNLOAD AS ASCII FILES, BUT SPSS FILES WORK WITH 
###       read.spss FUNCTION FROM foreign PACKAGE)

c1960a<-read.spss("DS0038_1960a/02896-0038-Data.sav", to.data.frame=TRUE)
c1960b<-read.spss("DS0039_1960b/02896-0039-Data.sav", to.data.frame=TRUE)
# c1960c<-read.spss("DS0040_1960c/02896-0040-Data.sav", to.data.frame=TRUE)

#THESE DATASETS INCLUDE STATE-LEVEL AND COUNTY-LEVEL DATA
## TO REMOVE THE STATE-LEVEL DATA (LEVEL = 2) and COUNTRY-LEVEL (LEVEL = 3), 
## WE CAN SIMPLY EXCLUDE ALL ROWS WHERE THE LEVEL == 2 OR 3
c1960a <- subset(c1960a, LEVEL < 2)
c1960b <- subset(c1960b, LEVEL < 2)

#RUN THIS TO SEE LOST OF COLUMN NAMES IN THESE DATASETS. 
## TO IDENTIFY WHAT THESE VARIABLES ARE, SEE THE 02896 CODEBOOK INCLUDED IN THE ZIP FILE
## WHEN YOU DOWNLOADED THESE DATASETS
#colnames(c1960a)

#BELOW I USED THE subset FUNCTION TO SELECT ONLY THOSE VARIABLES / COLUMNS I WANT TO KEEP
## ALTHOUGH THERE ARE 3 DATASETS FROM 1960, I AM ONLY CHOOSING VARS FROM THE FIRST 2
c1960a_sub<-subset(c1960a, select = c("FIPS", "NAME", "TOTPOP", "MTOT", "FTOT", "WHTOT"))
c1960b_sub<-subset(c1960b, select = c("FIPS", "NWTOT"))




#MERGE THE TWO 1960 DATASETS TOGETHER
c1960_sub <- merge(c1960a_sub, c1960b_sub, by = "FIPS")

#ADD "_1960" SUFFIX TO ALL VARIABLES EXCEPT FOR "FIPS" (WHICH WE WILL USE TO MERGE WITH OTHER DATASETS)
colnames(c1960_sub)[c(2:7)] <- paste(colnames(c1960_sub)[c(2:7)], '1960', sep = '_')



#1890
c1890<-read.spss("DS0018_1890/02896-0018-Data.sav", to.data.frame=TRUE)
# c1890 <- subset(c1890, LEVEL < 2)
c1890_sub <- subset(c1890, select = c("FIPS", "TOTPOP", "WHTOT", "NEG1870", "NEG1880", "NEGTOT", #1890 HAS OTHER RACES LIKE CHINESE, JAPANESE, AND "CIVILIZED INDIAN"
                                      "MTOT", "FTOT"))
colnames(c1890_sub)[c(2:3,6:8)] <- paste(colnames(c1890_sub)[c(2:3,6:8)], '1890', sep = '_')



#1900
c1900<-read.spss("DS0020_1900/02896-0020-Data.sav", to.data.frame=TRUE)
# c1900 <- subset(c1900, LEVEL < 2)
c1900_sub <- subset(c1900, select = c("FIPS", "TOTPOP", "WHTOT", "NEGFTOT", "NEGMTOT", 
                                      "MTOT", "FTOT"))
colnames(c1900_sub)[c(2:7)] <- paste(colnames(c1900_sub)[c(2:7)], '1900', sep = '_')



#1910
c1910<-read.spss("DS0022_1910/02896-0022-Data.sav", to.data.frame=TRUE)
# c1910 <- subset(c1910, LEVEL < 2)
c1910_sub <- subset(c1910, select = c("FIPS", "TOTPOP", "WHTOT", "NEGFTOT", "NEGMTOT", 
                                      "MTOT", "FTOT"))
colnames(c1910_sub)[c(2:7)] <- paste(colnames(c1910_sub)[c(2:7)], '1910', sep = '_')



#1920
c1920<-read.spss("DS0024_1920/02896-0024-Data.sav", to.data.frame=TRUE)
# c1920 <- subset(c1920, LEVEL < 2)
c1920_sub <- subset(c1920, select = c("FIPS", "TOTPOP", "WHTOT", "NEGFTOT", "NEGMTOT", 
                                      "MTOT", "FTOT"))
colnames(c1920_sub)[c(2:7)] <- paste(colnames(c1920_sub)[c(2:7)], '1920', sep = '_')




#1930 (only need Part 26 for 1930 not 27 or 28)
c1930<-read.spss("DS0026_1930a/02896-0026-Data.sav", to.data.frame=TRUE)
# c1930 <- subset(c1930, LEVEL < 2)
c1930_sub <- subset(c1930, select = c("FIPS", "TOTPOP", "WHTOT", "NEGFTOT", "NEGMTOT", 
                                      "MTOT", "FTOT"))
colnames(c1930_sub)[c(2:7)] <- paste(colnames(c1930_sub)[c(2:7)], '1930', sep = '_')




#1940 only Part 32
c1940<-read.spss("DS0032_1940a/02896-0032-Data.sav", to.data.frame=TRUE)
# c1940 <- subset(c1940, LEVEL < 2)
c1940_sub <- subset(c1940, select = c("FIPS", "TOTPOP", "WHTOT", "NEGTOT", 
                                      "MTOT", "FTOT"))
colnames(c1940_sub)[c(2:6)] <- paste(colnames(c1940_sub)[c(2:6)], '1940', sep = '_')



#1950
c1950a <- read.spss("DS0035_1950a/02896-0035-Data.sav", to.data.frame=TRUE)
# c1950a <- subset(c1950a, LEVEL < 2)
c1950a_sub <- subset(c1950a, select = c("FIPS", "TOTPOP", "NEGFTOT", "NEGMTOT", #"NWTOT",
                                      "MTOT", "FTOT"))
colnames(c1950a_sub)[c(2:6)] <- paste(colnames(c1950a_sub)[c(2:6)], '1950', sep = '_')

#1950
c1950b <- read.spss("DS0036_1950b/02896-0036-Data.sav", to.data.frame=TRUE)
# c1950b <- subset(c1950b, LEVEL < 2)
c1950b_sub <- subset(c1950b, select = c("FIPS", "WHTOT", "NWTOT"))
colnames(c1950b_sub)[c(2:3)] <- paste(colnames(c1950a_sub)[c(2:3)], '1950', sep = '_')

c1950_sub <- merge(c1950a_sub, c1950b_sub, by = "FIPS")

#NOTE - WE DID 1960 DATA AS THE FIRST EXAMPLE ABOVE!!



#NOW WE CAN DO THE SAME WITH 1970 CENSUS DATA, WHICH IS ONLY ONE DATASET
c1970<-read.spss("DS0041_1970/02896-0041-Data.sav", to.data.frame=TRUE)
# c1970 <- subset(c1970, LEVEL < 2)
c1970_sub <- subset(c1970, select = c("FIPS", "TOTPOP", "WPOP", "NEGTOT", "OTHRACES", "MTOT", "FTOT"))
colnames(c1970_sub)[c(2:7)] <- paste(colnames(c1970_sub)[c(2:7)], '1970', sep = '_')

#WE CAN THEN MERGE MULTIPLE DATASETS ACROSS MULTIPLE DECADES (THIS IS WHY IT WAS IMPORTANT TO ADD
## THE "_1960" AND "_1970" SUFFIXES)
# c1960_70 <- merge(c1960, c1970_sub, by = "FIPS")

# c1960_70$NWTOT_1970 <- c1960_70$NEGTOT_1970 + c1960_70$OTHRACES_1970
#to see if non-white pop ("NEGTOT_1970" + "OTHRACES_1970") + white pop = total pop:
# c1960_70$addtot <- c1960_70$NWTOT_1970 + c1960_70$WPOP_1970


# write.table(c1960_70,"census1960-70.csv",sep=",",col.names=NA)

#FOR 1980 - 1990 POP WE CAN LOOK AT ICPSR 02896 PART 83, 19980 usa COUNTIES VARS 1083 --> ALSO HAS WHITE & BLACK POP GOING BACK TO 1960
# c1998a<-read.spss("DS0082_Counties_1998a/02896-0082-Data.sav", to.data.frame=TRUE)
c1998b<-read.spss("DS0083_Counties_1998b/02896-0083-Data.sav", to.data.frame=TRUE)
##note: 1998c has pop data for Hisp/non-Hisp people as well as AmInd/Eskimo/Aleut, and Asian/Pac Isl but for 1990s only
# c1998c<-read.spss("DS0084_Counties_1998c/02896-0084-Data.sav", to.data.frame=TRUE)

c1998b_sub<-subset(c1998b, select = c("FIPS", "PO20080D", "PO20090D", "PO25080D", "PO25090D", 
                                                 "PO26080D", "PO26090D", "PO30060D", "PO30070D", "PO30080D", "PO30090D",
                                                 "PO31060D", "PO31070D", "PO31080D", "PO31090D"))

c1998b_sub <- c1998b_sub %>%
  rename("TOTPOP_1980" = "PO20080D", "TOTPOP_1990" = "PO20090D", "MTOT_1980" = "PO25080D", "MTOT_1990" = "PO25090D", 
         "FTOT_1980" = "PO26080D", "FTOT_1990" = "PO26090D", 
         "WTOT_1960" = "PO30060D", "WTOT_1970" = "PO30070D", "WTOT_1980" = "PO30080D", "WTOT_1990" = "PO30090D",
         "BTOT_1960" = "PO31060D", "BTOT_1970" = "PO31070D", "BTOT_1980" = "PO31080D", "BTOT_1990" = "PO31090D")

#to differentiate between 1960 and 1970 pop values from this dataset and from datasets 38 and 39 (in ICPSR 02896)
## we should label these columns with a suffix indicating the dataset they are from!
colnames(c1998b_sub)[c(2:15)] <- paste(colnames(c1998b_sub)[c(2:15)], 'ds83', sep = '_')

#FOR 1980-2000 COUNTY-LEVEL POPULATION; THE 2000 COUNTY DATA BOOK IN ICPSR 02896 HAS POP FOR THESE 3 DECENNIAL CENSUS YEARS

cty2000<-read.spss("DS0081_2000_CountyBook/02896-0081-Data.sav", to.data.frame=TRUE)
# cty2000 <- subset(cty2000, LEVEL < 2)
cty2000_sub <- subset(cty2000, select = c("FIPS", "B1_POP03", "B1_POP15", "B2_POP02", "B2_POP03",
                                          "B2_POP05", "B2_POP07", "B2_POP09", "B2_POP11", "B2_POP13", "B2_POP15", "B2_POP17"))
cty2000_sub <- cty2000_sub %>%
  rename("TOTPOP_2000" = "B1_POP03", 'HISPPOP_2000' = "B1_POP15", "MTOT_2000" = "B2_POP02", "FTOT_2000" = "B2_POP03",
         "WHTOT_2000" = "B2_POP05", "BTOT_2000" = "B2_POP07", "AMINDTOT_2000" = "B2_POP09", "ASTOT_2000" = "B2_POP11", 
         "PACISL_TOT_2000" = "B2_POP13", "ONERACE_OTHER_2000" = "B2_POP15", "TWOPLUSRACES_2000" = "B2_POP17")



##Note: some counties and all state / national summary data lost with this merge
df_list <- list(c1890_sub, c1900_sub, c1910_sub, c1920_sub, c1930_sub, c1940_sub, c1950_sub, c1960_sub, c1970_sub, c1998b_sub, cty2000_sub)
pop1890_2000 <- df_list %>%
  reduce(inner_join, by = "FIPS")

write.table(pop1890_2000,"census_race_1890_2000.csv",sep=",", col.names=NA)

pop_Grafton_1890_2000 <- subset(pop1890_2000, FIPS == 33009)

write.table(pop_Grafton_1890_2000,"census_GraftonNH_race_1890_2000.csv",sep=",", col.names=NA)


#TO LOAD 2000, 2010, AND 2020 DATA WE CAN USE THE CENSUS API AND SO THUS DO NOT HAVE TO DOWNLOAD AND IMPORT THE DATA FROM ICPSR
## I already downloaded the data from ICPSR for 2000, but let's use the Census API to import 2010 and 20 data.

setwd("C:/Users/F0040RP/documents/DartLib_RDS/censusData")


# TO ACQUIRE A CENSUS API KEY
## 1. Request a key here:
## https://api.census.gov/data/key_signup.html
## 2. Save the key in a plain text file that you save as "census_api.txt
## within your working directory (the folder you have set as your w.d. with setwd() above)
## 3. Open the census key in a plain text file with the commands below:
fileName<-"census_api.txt"
c<-read_file(fileName)
c<-readChar(fileName,file.info(fileName))

census_api_key(c, install = TRUE, overwrite=TRUE)  #install - only have to run this line once
# First time, reload your environment so you can use the key without restarting R.
readRenviron("~/.Renviron")
# You can check it with:

# Sys.getenv("CENSUS_API_KEY")
Sys.getenv(c)


# Working with other variables

# Thusfar, we have worked with only one or two variables. Decennial data, however, includes thousands of variables. 
# 
# Load variables from the 2000 - 2020 censuses using the following code. Note: the 2020 census data available in tidycensus only has the "pl" dataset available, which only contains a limited range of variables (most about race/ethnicity). Meanwhile, the 2010 and 2000 datasets contain far more variables.
# 
# 1. 2000 census: "pl", "sf1", "sf2", "sf3", "sf4" datasets available for import
# 2. 2010 census: "pl", "sf1", "sf2" datasets available
# 3. 2020 census: "pl" dataset available


decennial_2010_vars <- load_variables(
  year = 2010, 
  "pl", 
  cache = TRUE
)

decennial_2020_vars <- load_variables(
  year = 2020, 
  "pl", 
  cache = TRUE
)

acs_2010_vars <- load_variables(
  year = 2021, 
  "acs5", 
  cache = TRUE
)


pop2020 <- get_decennial(geography = "county", 
                       variables = c("P1_001N", "P1_003N", "P1_004N", "P1_005N", 
                                     "P1_006N", "P1_007N", "P1_008N","P1_009N", 
                                     "P2_002N", "P2_003N"),  
                       year = 2020)




#We may also request this same data at the census tract level. 
#However, as the tidycensus page explains, you must select a state or county for 
#data at the census tract level. You may not request data for the entire nation 
#at the census tract level. 
#See: [Geography in tidycensus](https://walker-data.com/tidycensus/articles/basic-usage.html#geography-in-tidycensus). 
              

pop2020tr <- get_decennial(geography = "tract", 
                         state = "NH",     
                         #variables = "P013001", #2010
                         variables = c("P1_001N", "P1_003N", "P1_004N", "P1_005N", 
                                       "P1_006N", "P1_007N", "P1_008N","P1_009N", 
                                       "P2_002N", "P2_003N"), 
                         year = 2020)   

pop2020tr_wide <- pop2020tr %>% 
  pivot_wider(names_from = "variable", values_from = "value")

pop2020tr_wide <- rename(pop2020tr_wide, c("totpop" = "P1_001N", "whpop" = "P1_003N", "blpop" = "P1_004N",
                         "aipop" = "P1_005N", "aspop" = "P1_006N", "nhpop" = "P1_007N",
                         "OneOtherpop" = "P1_008N", "multiracial_pop" = "P1_009N",
                         "hisp_pop" = "P2_002N", "nonhisp_pop" = "P2_003N"))

pop2020tr_wide$nwpop = pop2020tr_wide$totpop - pop2020tr_wide$whpop

setwd("C:/Users/F0040RP/documents/DartLib_RDS/external_Workshops/StAnselm/Day3_Maps")
write.table(pop2020tr_wide, "census_tract_pop_NH.csv", sep=",", col.names=NA)

