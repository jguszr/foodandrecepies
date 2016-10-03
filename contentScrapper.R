##
# The Scrapper
##

require(dplyr)
require(rvest)
require(jsonlite)

source("linkGrabber.R")

cfg<- loadConfiguration()

scrappDataDir <- "./Data/Scrapper/"

configureScrapperData <- function() {
  message("Checking Scrapper data files")
  
  if (!file.exists(scrappDataDir)) {
    dir.create(scrappDataDir)
    message("New Folder Created !!")
  }
}

scrapeIt<-function(fname) {
  configureScrapperData
  links <- tbl_df(read.table(fname,header=TRUE,sep=";"))
  
  links<- mutate(links, address=as.character(address)) %>%
    arrange(address)
  
  #needs a better filter
  links<- subset(links,grepl("^http|^www",links$address)) 
  content<- list()
  for (l in unique(links$address)) {
    ingredients <- list()
    prepMode <-list()    
    for(idd in cfg$sites$id) {
      if(grepl(idd,l)>0) {
        message("getting stuff from",l)        
        tryCatch({
            page<- read_html(l)
            ingredients <- sapply(as.list(html_nodes(page, subset(cfg$sites,id ==idd)$ingredients )),FUN = html_text)
            prepMode <- sapply(as.list(html_nodes(page, subset(cfg$sites,id ==idd)$premode )),FUN = html_text)
          },
          error= function(e) {
            message("Bad penny !")
            return(NA)
          }
        )
        Sys.sleep(4)
        gc()
      }
    }
    if(length(ingredients)>0 && length(prepMode)>0) {
      content <- list("ingredients"=ingredients,"prepmode"=prepMode,"link"=l)
      write(toJSON(content),file = paste(scrappDataDir,idd,".json",sep = ""),append = TRUE)
      print(toJSON(content))    
    } else {
      message("skipping ",l)
    }
    
  }
  return(content)
  
}

