library(Rcpp)
sourceCpp('rcpp_functions.cpp')
sourceCpp('reverse_string.cpp')


## generate data
animal <- c('koala', 'hedgehog', 'sloth', 'panda')
animals_frame <- data.frame(animal)
n <- 800
animals_frame_n <- do.call("rbind", replicate(n, animals_frame, simplify = FALSE))





## process R dataframe on R function
animals_frame_n['length'] <- 1
animals_frame_n$length <- as.numeric(animals_frame_n$length)


start <- Sys.time()
for (i in 1:nrow(animals_frame_n)) { 
  
  row <- animals_frame_n['animal'][i,]
  animals_frame_n['length'][i,] <- stri_reverse(row)
  #print(stringLength(row))
  
}

end <- Sys.time()


R_function_time_frame <- difftime(end, start, units="secs")


p <- reverse_string('tosha')




## process R dataframe on C++ function
animals_frame_n['length'] <- 1
animals_frame_n$length <- as.numeric(animals_frame_n$length)

start <- Sys.time()
for (i in 1:nrow(animals_frame_n)) { 
  
  row <- animals_frame_n['animal'][i,]
  animals_frame_n['length'][i,] <- reverse_string(row)
  #print(stringLength(row))
    
}

end <- Sys.time()

cpp_function_time_frame <- difftime(end, start, units="secs")










## process R vector on R function; write to R vector
animals_frame_n_vector <- as.vector(animals_frame_n[,2])

animal_lengths <- vector(mode="character", length=length(animals_frame_n_vector))


start <- Sys.time()
for (i in 1:length(animals_frame_n_vector)) { 
  
  row <- animals_frame_n_vector[i]
  animal_lengths[i] <- nchar(row)
  #print(stringLength(row))
  
}

end <- Sys.time()


R_function_vector_time <- difftime(end, start, units="secs")




## process R vector on C++ function; write to vector 
start <- Sys.time()

r <- as.character(animals_frame_n['animal'])
animal_lengths <- stringLength_vector(r)


end <- Sys.time()


cpp_function_vector_time <- difftime(end, start, units="secs")




times <- list()

times[1] <- R_function_time_frame
times[2] <- cpp_function_time_frame
times[3] <- R_function_vector_time
times[4] <- cpp_function_vector_time




