# Food & Recepies mission on Earth is :
## To crawl, clean, standardize (if possible) and provide a view on how food recipes vary thru different cultures.

## Basic Definitions :

* Its All on R, all the time (unless something impossible to do in R comes along , then I'll probably go to Python or something more ninja)
* It's Open, free and awsome, unless you try to use it professionaly ! If so, by me a beer !
*

###  Todo List :

* define :
  * database (Mongo, MySql, MariaDb, IBM cloundsomething, Amazon Something somenthing)
  * url seed specific configuration File to handle css selectors, xpath stuff among possible others.
  
### Dependencies 
* rvest
* XML
* R Web Scraper http://factotumjack.blogspot.com.br/2015/10/an-r-based-web-crawler-scraper.html 
* Dplyr
* jsonlite

### Contributors

* if you like coocking (for real, no  micro wave pizza here), and enjoy stats,R coding, exploratory analysis, web scrapping, harvesting data, this project is for you !!  enlist !!  

### basics 

1. folders and contents :
    * _exploratory_ : exploratory code for different libs and assumptions
    * _config_ : it contains *.json files to configure some aspects of the crawker and scrapper.
    * _core_ : the application functions itself __to be refactored__
    * _Data_ : Folder to handle all fetched data and processed the data, the deeper the level more process the original that had being subjected. Folders shoud be named with one single word.
  
  
  