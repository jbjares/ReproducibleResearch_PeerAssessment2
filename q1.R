#source("global.R")

#1) Across the United States, which types of events 
#(as indicated in the EVTYPE variable) are most harmful with respect to population health?
 
mostHarmfulEventsForPopulationHealth <- function(){
        library(sqldf)
        sumOfFatalities <- sqldf("select EVTYPE, sum(FATALITIES) as sumF from mainFullDF group by EVTYPE")
        sumOfInjuries <- sqldf("select distinct(EVTYPE), sum(INJURIES) as SumI from mainFullDF group by EVTYPE order by SumI desc limit 10")
        
       print(sumOfInjuries)
}


mutatePropDMG <- function(){
        library(dplyr)
        mainFullDF <<- mainFullDF %>%
                mutate(FPROPDMG = ifelse(is.null(PROPDMGEXP) | is.na(PROPDMGEXP) | PROPDMGEXP=="",0,
                                           ifelse(PROPDMGEXP=='H',2,
                                                  ifelse(PROPDMGEXP=='K',3,
                                                        ifelse(PROPDMGEXP=='M',6,
                                                               ifelse(PROPDMGEXP=='B',9,PROPDMGEXP))))))
}

mutateCropDMG <- function(){
        library(dplyr)
        mainFullDF <<- mainFullDF %>%
                mutate(FCROPDMG = ifelse(is.null(CROPDMGEXP) | is.na(CROPDMGEXP) | CROPDMGEXP=="",0,
                                           ifelse(CROPDMGEXP=='H',2,
                                                  ifelse(CROPDMGEXP=='K',3,
                                                         ifelse(CROPDMGEXP=='M',6,
                                                                ifelse(CROPDMGEXP=='B',9,CROPDMGEXP))))))
        
}


sumOfMostdemageprops <- function(){
        library(sqldf)
        sumOfMostdemageprops <- sqldf("select EVTYPE, sum(FPROPDMG) as sumProp from mainFullDFtmp group by EVTYPE order by sumProp desc limit 10")
        #sumOfInjuries <- sqldf("select distinct(EVTYPE), sum(INJURIES) as SumI from mainFullDF group by EVTYPE order by SumI desc limit 10")
        
        print(sumOfMostdemageprops)
}
#sumOfMostdemageprops()




sumOfMostdemageCrops <- function(){
        library(sqldf)
        sumOfMostdemageCrops <- sqldf("select EVTYPE, sum(FCROPDMG) as sumCrop from mainFullDFtmp group by EVTYPE order by sumCrop desc limit 10")
        
        print(sumOfMostdemageCrops)
}
sumOfMostdemageCrops()