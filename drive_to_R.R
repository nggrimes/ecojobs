# load in sheets
library(googlesheets4)
sheet<-read_sheet('https://docs.google.com/spreadsheets/d/1V_lqrvAJUTGpFPQ7oTPWh9ooiTRbmS2BC4PJuaKWZk4/edit?gid=0#gid=0',range='A3:M25') #note this is hard coded for now. Rearrange later


# load in text data from the google doc as database
library(googledrive)

file=drive_get("EcoJobs Fill in")

drive_download(file,type='text/plain',path='temp_doc.txt',overwrite=TRUE)

text<-readLines("temp_doc.txt")


#### Extract information from doc and place into each cell ####

# temp for loop index holders, i for rows, j for cols

i=4
j=1

# define column boundaries

end_col=colnames(sheet)[i]
beg_col=colnames(sheet)[i-1]

end_row=sheet$`Environmental Fields`[j]
beg_row=sheet$`Environmental Fields`[j]

# merge to form boundaries

end_merge<-paste(end_row,end_col,sep=" ")
beg_merge<-paste(beg_row,beg_col,sep=" ")

# search for the terms in the text file

library(stringr)

end_which<-str_which(text,end_merge)
beg_which<-str_which(text,beg_merge)

check_end<-which(str_length(end_merge)==str_length(text[end_which]))

end_index=end_which[check_end]

check_beg<-which(str_length(beg_merge)==str_length(text[beg_which]))

beg_index=beg_which[check_beg]



# extract the relevant text

t<-text[beg_index:(end_index-1)]


#Make a lists of list to store all information
test<-lapply(as.list(sheet),as.list)

test[[i-1]][[j]]<-t
