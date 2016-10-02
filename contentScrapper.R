##
# The Scrapper
##

require(dplyr)
require(rvest)

source("linkGrabber.R")

cfg<- loadConfiguration()

configureScrapperData <- function() {
  message("Checking Scrapper data files")
  
  if (!file.exists("./Data/Scrapper")) {
    dir.create("./Data/Scrapper")
    message("New Folder Created !!")
  }
}

scrapeIt<-function(fname) {
  
  links <- tbl_df(read.table(fname,header=TRUE,sep=";"))
  
  links<- mutate(links, address=as.character(address)) %>%
    arrange(address)
  
  #needs a better filter
  links<- subset(links,grepl("^http|^www",links$address)) 
  
  for (l in unique(links$address)) {
    for(idd in cfg$sites$id) {
      if(grepl(idd,l)>0) {
        message("getting stuff from",l)        
        page<- read_html(l)
        html_text(page)
        incredients <- html_nodes(page, subset(cfg$sites,id ==idd)$ingredients )
        prepMode <- html_nodes(page, subset(cfg$sites,id ==idd)$premode )
        Sys.sleep(3)
        gc()
      }
    }
  }
}

