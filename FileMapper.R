##
# Ingredients Mapper
##

source("linkGrabber.R")

cfg<- loadConfiguration()

mergedDataDir <- "./Data/Scrapper/Merged/"
toBeRead <- "./Data/Scrapper/"
prepFName <-"preparationMode.csv"
ingredientsFName<-"ingredients.csv"

configureMergedData <- function() {
  message("Checking Merged data files")
  
  if (!file.exists(mergedDataDir)) {
    dir.create(mergedDataDir)
    message("New Folder Created !!")
  }
}

mergeIngredients <- function(toRead=toBeRead) {
  configureMergedData()
  fileList <- list.files(toRead,pattern = "*.json")
  ingredients <- list()
  titles <- list()
  df_prep_final <- data.frame()
  df_ingredients_final <- data.frame()
  message("files to be read : ", length(fileList))
  for (f in fileList) {
    jcontent <- fromJSON(txt=paste(toRead,f,sep=""), simplifyDataFrame = TRUE)
    df_prep<- data.frame(jcontent$prepmode, stringsAsFactors = FALSE)
    names(df_prep) <- c("prepMode")
    df_prep$recepieName <- rep(jcontent$title,length.out=length(jcontent$prepmode))
    df_prep$recepieLink <- rep(jcontent$link,length.out=length(jcontent$prepmode))
    df_prep$originalFile <- rep(f,length.out=length(jcontent$prepmode))
    df_prep_final<- rbind(df_prep_final,df_prep)
    
    df_ingredients<- data.frame(jcontent$ingredients, stringsAsFactors = FALSE)
    names(df_ingredients) <- c("ingredients")
    df_ingredients$recepieName <- rep(jcontent$title,length.out=length(jcontent$ingredients))
    df_ingredients$recepieLink <- rep(jcontent$link,length.out=length(jcontent$ingredients))
    df_ingredients$originalFile <- rep(f,length.out=length(jcontent$ingredients))
    df_ingredients_final <- rbind(df_ingredients_final, df_ingredients)
  }
  if (file.exists(paste0(mergedDataDir,prepFName)) &&
      file.exists(paste0(mergedDataDir,ingredientsFName))) {
    
    write.table(df_prep_final,paste0(mergedDataDir,prepFName),append = TRUE,sep=";")
    write.table(df_ingredients_final,paste0(mergedDataDir,ingredientsFName), append = TRUE,sep=";" )
    
  } else {
    write.table(df_prep_final,paste0(mergedDataDir,prepFName),append = FALSE,sep=";")
    write.table(df_ingredients_final,paste0(mergedDataDir,ingredientsFName), append = FALSE,sep=";" )
    
  }
}

mergeIngredients()
