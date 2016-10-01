##
# URL Grabbler
#
##
require(jsonlite)
source("WebScrapper.r")

configFile <- "./config/config.json"
linkfile <- "./Data/links.csv"
edgefiles <- "./Data/edges.csv"


configureData <- function() {
  message("Checking data files")
  
  if (!file.exists("./Data")) {
    dir.create("./Data")
  }
  
  
}

loadConfiguration <- function() {
  if (file.exists(configFile)) {
    message("config file founded !!!")
    return(fromJSON(configFile))
    print(theConfig)
    
  } else {
    message("No config file found !")
  }
}

saveData<- function(toBeSaved) {
  
  message("writing the file links")
  if (file.exists(linkfile)  ) {
    message("appending stuff")
    write.table(toBeSaved$nodes,file = linkfile,sep = ";",row.names = FALSE, col.names = FALSE ,append = TRUE)  
  } else {
    message("creating the files")
    write.table(toBeSaved$nodes,file = linkfile,sep = ";",row.names = FALSE, append = FALSE)  
  }
  
  message("writing the file edgefiles")
  if (file.exists(linkfile)  ) {
    message("appending stuff")
    write.table(toBeSaved$edges,file = edgefiles,sep = ";",row.names = FALSE, col.names = FALSE ,append = TRUE)  
  } else {
    message("creating the files")
    write.table(toBeSaved$edges,file = edgefiles,sep = ";",row.names = FALSE, append = FALSE)  
  }
  
  
  
}


fetchLinksAndSave <- function(filename = linkfile, nSize = 10) {
  message("Fetchinking links - getting source")
  toBeSaved <- list()
  cfg <- loadConfiguration()
  print(cfg)
  configureData()
  for (seed in cfg$sites$seed) {
    toBeSaved <- web_crawl(url_seed = cfg$sites$seed, Npages = nSize)
  }
  saveData(toBeSaved)
  return(toBeSaved)
  
}


