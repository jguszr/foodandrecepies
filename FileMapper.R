##
# Ingredients Mapper
##

source("linkGrabber.R")

cfg<- loadConfiguration()

mergedDataDir <- "./Data/Scrapper/Merged/"
toBeRead <- "./Data/Scrapper/"

configureMergedData <- function() {
  message("Checking Merged data files")
  
  if (!file.exists(mergedDataDir)) {
    dir.create(mergedDataDir)
    message("New Folder Created !!")
  }
}

mergeIngredients <- function(toRead=toBeRead) {
  
  fileList <- list.files(toRead)
  ingredients <- matrix()
  titles <- matrix()
  message("files to be read : ", length(fileList))
  for (f in fileList) {
    jcontent <- fromJSON(paste(toRead,f,sep=""))
    ingredients <-rbind(ingredients,jcontent$ingredients)
    #append(titles,rep(jcontent$title,times=length(jcontent$ingredients)))
    
    print(ingredients)
    print(titles)
  }
  return(cbind(ingredients,titles))
}

tst<-mergeIngredients()
