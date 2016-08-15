rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(httr)
orgURL = 'http://www.boxofficemojo.com/yearly/chart/?view2=worldwide&yr='
startPage = 1980
endPage = 2016
alldata = data.frame()
for( i in startPage:endPage)
{
  tempdata = data.frame()
  pttURL <- paste(orgURL,i,'&p=.htm', sep='')
  urlExists = url.exists(pttURL)
  if(urlExists)
  {
    html = getURL(pttURL, ssl.verifypeer = FALSE)
    xml = htmlParse(html, encoding ='utf-8')
    linkTemp = xpathSApply(xml, "//font[@size=\"2\"]/a//@href")
    link = linkTemp[-(c(1,2,3,4,5,6,7,8,9))]
    titleTemp = xpathSApply(xml, "//font/a/b", xmlValue)
    title = titleTemp[-(c(1,2))]
    title[pmatch("Rams", title)] = "Rams"
    responseTemp = xpathSApply(xml, "//table//font/b",xmlValue)
    response = unlist(responseTemp[-(length(responseTemp))])
    domestic = unlist(xpathApply(xml, "//td[@align=\"right\"][2]",xmlValue))
    domestic2 = unlist(xpathApply(xml, "//td[@align=\"right\"][3]",xmlValue))
    foreign = unlist(xpathApply(xml,"//td[@align=\"right\"][4]",xmlValue))
    foreign2 = unlist(xpathApply(xml, "//td[@align=\"right\"][5]",xmlValue))
    #author = xpathSApply(xml, "//div[@class='author']", xmlValue)
    #path = xpathSApply(xml, "//div[@class='title']/a//@href")
    #date = xpathSApply(xml, "//div[@class='date']", xmlValue)
    tempdata = data.frame(link,title,response, domestic,domestic2,foreign,foreign2)
  }
  
  alldata = rbind(alldata,tempdata)
  
}
write.csv(alldata,"alldata.csv")
    
