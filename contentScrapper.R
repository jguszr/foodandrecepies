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
  
  if( "degree_total" %in% names(links)) {
    message("edgefiles being handle !")
    #filtering incomplete urls that can be merged with the address field to form a fully functional URL.
    links<- subset(links,grepl("^/[a-z]",links$degree_total)) 
    
    #filtering complete urls that end's with the domain termination (org,br,com etc)
    links<- subset(links,grepl("\\.br|\\.com/[a-zA-Z]$",links$address)) 
    links<-mutate(links,address=paste0(as.character(address),as.character(degree_total)))
  } else {
    links<- mutate(links, address=as.character(address))  
  }
  
  #needs a better filter
  links<- subset(links,grepl("^http|^www",links$address)) 
  
  content<- list()
  for (l in unique(links$address)) {
    ingredients <- list()
    prepModes <-list()    
    titles <- list()
    for(idd in cfg$sites$id) {
      if(grepl(idd,l)>0) {
        message("getting stuff from ",l)        
        tryCatch({
            page<- read_html(l)
            ingredients <- lapply(as.list(html_nodes(page, subset(cfg$sites,id ==idd)$ingredients )),FUN = html_text)
            prepModes <- lapply(as.list(html_nodes(page, subset(cfg$sites,id ==idd)$prepmode )),FUN = html_text)
            titles <- lapply(as.list(html_nodes(page, subset(cfg$sites,id ==idd)$title )),FUN = html_text)
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
    if(length(ingredients)>0 && length(prepModes)>0) {
      content <- list("title"=titles, 
                      "ingredients"=ingredients,
                      "prepmode"=prepModes,
                      "link"=l[1],
                      "ts"=format.Date(Sys.time(),"%h%m%s-%d%m%y")
                      )
      
      write(toJSON(content),file = paste(scrappDataDir,format.Date(Sys.time(),"%h%m%s%d%m%y"),".json",sep = ""),append = TRUE)
      print(toJSON(content))    
    } else {
      message("skipping ",l)
    }
    
  }
  return(content)
  
}

scrapeIt(linkfile)
