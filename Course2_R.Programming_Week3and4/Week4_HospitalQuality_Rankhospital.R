setwd("C:/Users/futong/Desktop/Coursera/R_work/R_week4_assignment")

rankhospital <- function(state, outcome, num="best"){
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        df<- as.data.frame(cbind(data[, 7], data[, 11], data[, 17],  data[, 23], data[, 2]), stringsAsFactors = FALSE)
        colnames(df) <- c("state", "heart attack", "heart failure", "pneumonia","hospital")
        
        if(!state %in% outcome2[, "state"]){
                stop('invalid state')
        } 
        else if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
                stop('invalid outcome')
        } 
        else if (is.numeric(num)){ 
                aa <- df[order(as.numeric(df[, outcome])), ]
                s_a <- split(aa, aa$state, drop=TRUE)
                mt <- sapply(s_a, function(x) x[num, ])
                df <- as.data.frame(mt)
                xa <- which(colnames(df)== state)
                ya <- df[ , xa]
                output <- (ya$hospital)
        }
        else if (!is.numeric(num)){
                if (num == "best"){
                        output <- best(state, outcome)
                } 
                else if (num == "worst") {
                        aa <- df[order(as.numeric(df[, outcome]), decreasing = TRUE), ]
                        s_a <- split(aa, aa$state, drop=TRUE)
                        mt <- sapply(s_a, function(x) x[1, ])
                        df <- as.data.frame(mt)
                        xa <- which(colnames(df)== state)
                        ya <- df[ , xa]
                        output <- (ya$hospital)
                        
                }
                else {
                        stop("invalid rank")
                }
        }
         return(output)
}