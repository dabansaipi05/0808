rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(httr)
orgURL = 'http://www.boxofficemojo.com/yearly/'
startPage = 1
endPage = 1
alldata = data.frame()
for( i in startPage:endPage)
{
  pttURL <- paste(orgURL, sep='')
  urlExists = url.exists(pttURL)
  if(urlExists)
  {
    html = getURL(pttURL, ssl.verifypeer = FALSE)
    xml = htmlParse(html, encoding ='utf-8')
    title = xpathSApply(xml, "//font[@size='4']/a//@href")        
    #author = xpathSApply(xml, "//div[@class='author']", xmlValue)
    #path = xpathSApply(xml, "//div[@class='title']/a//@href")
    #date = xpathSApply(xml, "//div[@class='date']", xmlValue)
    #response = xpathSApply(xml, "//div[@class='nrec']", xmlValue)
    tempdata = data.frame(title)
  }
  alldata = rbind(alldata, tempdata)
}
allDate = levels(alldata$date)
#res = hist(as.numeric(alldata$date), nclass=length(allDate), axes=F)
#axis(1, at=1:length(allDate), labels=allDate)
#axis(2, at=1:max(res$counts), labels=1:max(res$counts))
write.csv(alldata,"alldata.csv")

