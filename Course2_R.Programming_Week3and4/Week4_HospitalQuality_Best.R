setwd()

best <- function(state, outcome){
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        df<- as.data.frame(cbind(data[, 7], data[, 11], data[, 17],  data[, 23], data[, 2]), stringsAsFactors = FALSE)
        colnames(df) <- c("state", "heart attack", "heart failure", "pneumonia","hospital")
        
        if(!state %in% outcome2[, "state"]){
                stop('invalid state')
        } else if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
                stop('invalid outcome')} 
        else { aa <- df[order(as.numeric(df[, outcome])), ]
        s_a <- split(aa, aa$state, drop=TRUE)
        mt <- sapply(s_a, function(x) head(x, 1))
        df <- as.data.frame(mt)
        xa <- which(colnames(df)== state)
        ya <- df[ , xa]
        output <- (ya$hospital)
        }
        return(output)
}