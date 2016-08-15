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
    tempdata = data.frame(link)
  }
  
  alldata = rbind(alldata,tempdata)
  
}
write.csv(alldata,"alldata2.csv")