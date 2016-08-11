rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(httr)
orgURL = 'http://www.boxofficemojo.com/yearly/chart/?view2=worldwide&yr=2016&p=.htm'
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
    title = xpathSApply(xml, "//a[@href]/b//text()", xmlValue) 
    response = xpathSApply(xml, "//td[@align='right'][1]/font//text()",xmlValue)
    domestic = xpathApply(xml, "//td[@align='right'][2]/font//text()",xmlValue)
    domestic2 = xpathApply(xml, "//td[@align='right'][3]/font//text()",xmlValue)
    foreign = xpathApply(xml,"//td[@align='right'][4]/font//text()",xmlValue)
    foreign2 = xpathApply(xml, "//td[@align='right'][5]/font//text()",xmlValue)
    #author = xpathSApply(xml, "//div[@class='author']", xmlValue)
    #path = xpathSApply(xml, "//div[@class='title']/a//@href")
    #date = xpathSApply(xml, "//div[@class='date']", xmlValue)
    tempdata = data.frame(title,response,domestic,domestic2,foreign,foreign2)
  }
  
alldata = rbind(alldata,tempdata)

}
write.csv(alldata,"alldata.csv")
