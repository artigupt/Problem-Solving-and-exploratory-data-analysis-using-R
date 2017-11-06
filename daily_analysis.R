library(tm)
library(wordcloud)
library(memoise)

# The list of valid date of elections
election_date <<- list("2016-02-26" = "tweets1",
                       "2016-02-27" = "tweets2",
                       "2016-02-28" = "tweets3",
                       "2016-02-29" = "tweets4",
                       "2016-03-01" = "tweets5",
                       "2016-03-02" = "tweets6",
                       "2016-03-03" = "tweets7")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(election) {
  
  if (!(election %in% election_date))
    stop("No Data available")
  
  text <- readLines(sprintf("./%s.txt.gz", election),
                    encoding="UTF-8")
  
  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))
  
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
  
  
})