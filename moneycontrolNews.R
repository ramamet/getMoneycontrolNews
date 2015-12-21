#loading libraries
library(rvest)
library(XML)
#number of pages to be scraped
start <- 1:4
# Collect URLs as list:
URLs <- paste("http://www.moneycontrol.com/news/all-news-All-",start,"-next-0.html",sep = "")
scraper_internal <- function(x) {
x.tmp=read_html(x)
doc <- htmlParse(x.tmp, encoding="UTF-8")
# titles:
news <- xpathSApply(doc, '//*[contains(concat( " ", @class, " " ), concat( " ", "title", " " ))]', xmlAttrs)
headlines=unique(rapply(news, function(x) tail(x, 1)))
headlines.df=data.frame(headlines)
headlines.df = headlines.df[-1,]
dat <- data.frame(headlines.df)
return(dat)
}
#resultant data frame
NEWS <- do.call("rbind", lapply(URLs, scraper_internal))
