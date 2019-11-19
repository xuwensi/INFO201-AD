library("dplyr")

status <- read.csv("data/status.csv", stringsAsFactors = FALSE);
races <- read.csv("data/races.csv", stringsAsFactors = FALSE);
results <- read.csv("data/results.csv", stringsAsFactors = FALSE);

analysis <- results %>%
  inner_join(status, by = "statusId") %>%
  inner_join(races, by = "raceId") 

View(analysis)

  