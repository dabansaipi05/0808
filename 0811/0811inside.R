rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(NLP)
library(httr)


#Sys.setlocale("LC_ALL", "cht")


alldata = read.csv('alldata.csv')
orgURL = 'http://www.boxofficemojo.com'
for( i in 1:length(alldata$link))
{
  tempdata= data.frame
  pttURL <- paste(orgURL, alldata$link, sep='')
  urlExists = url.exists(pttURL)
  
  if(urlExists)
  {
    html = getURL(pttURL, ssl.verifypeer = FALSE, encoding='UTF-8')
    xml = htmlParse(html, encoding='UTF-8')
    budg = xpathSApply(xml, "//center/table/tbody/tr[4]/td[2]/b", xmlValue)
    #dis = xpathSApply(xml, "//td[1]/b/a", xmlValue)
    #InR = xpathSApply(xml, "//table[3]/tbody/tr/td[2]", xmlValue)
    #open = xpathSApply(xml, "//div[2]/div[2]/table[1]/tbody/tr[1]/td[2]", xmlValue)
    #char = xpathSApply(xml,"//center/table/tbody/tr[3]/td[1]", xmlValue)
    tempdata = data.frame(budg)
  }
  alldata = rbind(alldata, tempdata)
}
write.csv(alldata,"alldata2.csv")