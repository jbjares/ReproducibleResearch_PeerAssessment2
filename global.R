

if(!("futile.logger" %in% rownames(installed.packages()))){
        install.packages("futile.logger")  
}
if(!("R.utils" %in% rownames(installed.packages()))){
        install.packages("R.utils")  
}

if(!exists("mainFullDF")){
        mainFullDF <<- NULL
}

library(futile.logger)

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


readMainFullDT <- function(){
        flog.info(paste0("into unzipFile, named: ",compressedFiledPATH))
                flog.info(paste0("file named: ",compressedFiledPATH," exists.. will be decompressed."))
                
                if (!file.exists(unCompressedFiledPATH)) {
                        library(R.utils)
                        bunzip2(compressedFiledPATH,unCompressedFiledPATH, remove = T)
                }

                flog.info(paste0("file named: ",compressedFiledPATH," decompressed, successful!"))
        
        flog.info(paste0("The file named: ",compressedFiledPATH, "is already decompressed."))
}

readMainFullDF <- function(){
        flog.info(paste0("into readMainFullDF"))
        
        if (is.null(mainFullDF)) {
                mainFullDF <<- read.csv2(unCompressedFiledPATH, header = TRUE, sep = ",")
        }
        flog.info(paste0("mainFullDF generated!"))

}


getFileByURL(mainFileURL)
readMainFullDT()
readMainFullDF()
