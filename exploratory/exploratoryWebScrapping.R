library(rvest)
#endPoint <- "http://www.cybercook.com.br/almondega-r-3-12467.html"
endPoint <- "http://www.cybercook.com.br/receita-de-massa-para-empadao-rapida-e-facil-r-13-18128.html?origin=outbrain"
page <- read_html(endPoint)
#get the ingredients
incredients <- html_nodes(page, "#content li ")
prepMode <-  html_nodes(page, "#modo-de-preparo ol li ")
title <-  html_nodes(page, "h1.g.i.fn.fl.titulo-receita-principal.tp.f32")
html_text(incredients)
html_text(prepMode)
html_text(title)

#endPoint <- "http://www.tudogostoso.com.br/receita/64759-sopa-de-feijao-branco.html"
endPoint<- "http://www.tudogostoso.com.br/receita/129-frango-com-catupiry-e-batata-palha-da-tia-gracia.html"
page<- read_html(endPoint)
incredients <- html_nodes(page, "#info-user ul li")
prepMode <- html_nodes(page, ".instructions ol li")
title <- html_nodes(page, ".page-recipe .left-content .recipe-title h1, .page-tip .left-content .recipe-title h1")
html_text(incredients)
html_text(prepMode)
html_text(title)

