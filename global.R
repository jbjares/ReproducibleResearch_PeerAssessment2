

if(!("futile.logger" %in% rownames(installed.packages()))){
        install.packages("futile.logger")  
}
if(!("R.utils" %in% rownames(installed.packages()))){
        install.packages("R.utils")  
}
if(!("data.table" %in% rownames(installed.packages()))){
        install.packages("data.table")  
}
if(!("dplyr" %in% rownames(installed.packages()))){
        install.packages("dplyr")  
}
if(!("sqldf" %in% rownames(installed.packages()))){
        install.packages("sqldf")
}
install.packages('stargazer')

if(!exists("mainFullDF")){
        mainFullDF <<- NULL
}


library(futile.logger)
library(data.table)
library(dplyr)

mainFileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2";
compressedFiledPATH <- paste0(getwd(),"/StormData.csv.bz2")
unCompressedFiledPATH <- paste0(getwd(),"/","StormData.csv")
getFileByURL <- function(url){
        flog.info(paste0("into getFileByURL where url is: ",url))
                if(!file.exists(compressedFiledPATH) & !file.exists(unCompressedFiledPATH)){
                        flog.info(paste0("file named ",compressedFiledPATH," doesnt exists."))
                        
                        download.file(url, compressedFiledPATH)
                        
                        flog.info(paste0("file: ",compressedFiledPATH,"downloaded with succsseful."))
                }
        flog.info(paste0("file named ",compressedFiledPATH," exists."))
        
}


unConpressFile <- function(){
        flog.info(paste0("into unzipFile, named: ",compressedFiledPATH))
                flog.info(paste0("file named: ",compressedFiledPATH," exists.. will be decompressed."))
                
                if (!file.exists(unCompressedFiledPATH)) {
                        library(R.utils)
                        bunzip2(compressedFiledPATH,unCompressedFiledPATH, remove = T)
                }

                flog.info(paste0("file named: ",compressedFiledPATH," decompressed, successful!"))
        
        flog.info(paste0("The file named: ",compressedFiledPATH, "is already decompressed."))
}

readMainFullDT <- function(){
        flog.info(paste0("into readMainFullDF"))
        
        if (is.null(mainFullDF)) {
                mainFullDF <<- read.csv2(unCompressedFiledPATH, header = TRUE, sep = ",")
        }
        flog.info(paste0("mainFullDF generated!"))

}

muateFormatingYears <- function(){
        library(dplyr)
        flog.info(paste0("into muateFormatingYears"))
        if (dim(mainFullDF)[2] == 38) {
                flog.info(paste0("will return NULL"))
                return(NULL)
        }
        mainFullDF <<- mainFullDF %>%
                mutate(FYEARS = (as.numeric(format(as.Date(BGN_DATE, format = "%m/%d/%Y %H:%M:%S"), "%Y"))))
        
        flog.info(paste0("out muateFormatingYears"))
}


getFileByURL(mainFileURL)
unConpressFile()
readMainFullDT()
muateFormatingYears()