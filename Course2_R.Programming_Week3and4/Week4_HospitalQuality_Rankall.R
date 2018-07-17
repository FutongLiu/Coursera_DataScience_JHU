setwd("C:/Users/futong/Desktop/Coursera/R_work/R_week4_assignment")

rankall <- function(outcome, num="best") {        
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        df <- as.data.frame(cbind(data[,2],data[,7], data[,11], data[,17], data[,23]), stringsAsFactors = FALSE)
        colnames(df) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")

        if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
                stop("invaild outcome")
        } else if (is.numeric(num)){
                a <- df[order(as.numeric(df[, outcome])),]
                b <- split(a, a$state, drop=TRUE)
                c <- sapply(b, function(x) x[num, ])
                d <- as.data.frame(c)
                output <- as.data.frame(t(rbind(d["hospital", ], d["state", ])))
        } else if (!is.numeric(num)){
                if (num == "best"){
                        a <- df[order(as.numeric(df[, outcome])),]
                        b <- split(a, a$state, drop=TRUE)
                        c <- sapply(b, function(x) x[1, ])
                        d <- as.data.frame(c)
                        output <- as.data.frame(t(rbind(d["hospital", ], d["state", ])))
                } else if (num == "worst") {
                        a <- df[order(as.numeric(df[, outcome]), decreasing = TRUE),]
                        b <- split(a, a$state, drop=TRUE)
                        c <- sapply(b, function(x) x[1, ])
                        d <- as.data.frame(c)
                        output <- as.data.frame(t(rbind(d["hospital", ], d["state", ])))
                } else {
                        stop("invalid num")
                }
                }
        return(output)
}


