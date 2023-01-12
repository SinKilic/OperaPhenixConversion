library(stringr)
library(gtools)
colno = 12
chan1 <- "A488"
chan2 <- "A647"
chan3 <- "DAPI"
chan4 <- "A568"
dir <- choose.dir()
files <- list.files(path = dir)
setwd(dir)
for (i in files) {
  row <- as.numeric(substr(i, 2, 3))
  col <- as.numeric(substr(i, 5, 6))
  ROW <- str_pad(row, 5, pad = "0")
  COL <- str_pad(col, 5, pad = "0")
  field <- as.numeric(substr(i, 8, 9))
  FIELD <- str_pad(field, 5, pad = "0")
  plane <- as.numeric(substr(i, 11, 12))
  PLANE <- str_pad(plane, 5, pad = "0") 
  channel <- as.numeric(substr(i, 16,16))
  WELL <- str_pad(((row*colno)-12+col), 5, pad = "0")
  rowlet <- chr(64+row)
  if (channel == 1) {
    chan = chan1
  } else if (channel == 2) {
    chan = chan2
  } else if (channel == 3) {
    chan = chan3
  } else if (channel == 4) {
    chan = chan4
  }
  name <- paste(rowlet, col, "--W", WELL, "--P", FIELD, "--Z", PLANE, "--T00000--", chan, ".tif", sep ='', collapse = NULL)
  file.rename(i, name)
}