## creates an R object that stores a matrix and its inverse

makeCacheMatrix <- function(x = matrix()) {
        m <- NULL ## m is initialized to NULL
        set <- function(y) {  ## Define set function, and x is initialized as a function argument
                x <<- y       ## Assign the y to the x object in the parent environment
                m <<- NULL    ## Assign NULL to the m in the parent environment
        }
        get <- function() x   ## Define get function, and retrieves a from makeCacheMatrix environment
        set_inverse <- function(solve) m <<- solve ## Define get_inverse, and assign the input argument solve to m in the parrent environment
        get_inverse <- function() m ## Define get_inverse for the value m
        list(set = set, get = get,  ## Create a new object by returning a list, and Assign each of these functions (set, get, set_inverse, get_inverse) as an element within a list, then returns to the parent environment
             set_inverse = set_inverse, ## Gives the name 'set' to the set() function defined above, and so on
             get_inverse = get_inverse)
}


## Calculate the inverse of the matrix created with the above function. 
## First, check if the calculation has been completed or not. 
## If so, skip the calculation and return the result from the cache. 
## If not, do the calculation and set the value to the cache.

cacheSolve <- function(x, ...) {
        m <- x$get_inverse() ## Return a matrix that is the inverse of 'x'
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        matrix <- x$get()
        m <- solve(matrix, ...)
        x$set_inverse(m)
        m
}
