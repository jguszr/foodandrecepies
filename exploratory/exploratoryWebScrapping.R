library(rvest)
#endPoint <- "http://www.cybercook.com.br/almondega-r-3-12467.html"
endPoint <- "http://www.cybercook.com.br/receita-de-empadao-de-frango-pratico-r-13-14468.html"
page <- read_html(endPoint)
#get the ingredients
incredients <- html_nodes(page, "#content li ")
prepMode <-  html_nodes(page, "#modo-de-preparo ol li ")
html_text(incredients)
html_text(prepMode)

#endPoint <- "http://www.tudogostoso.com.br/receita/64759-sopa-de-feijao-branco.html"
endPoint<- "http://www.tudogostoso.com.br/receita/129-frango-com-catupiry-e-batata-palha-da-tia-gracia.html"
page<- read_html(endPoint)
incredients <- html_nodes(page, "#info-user ul li")
prepMode <- html_nodes(page, ".instructions ol li")
html_text(incredients)
html_text(prepMode)

