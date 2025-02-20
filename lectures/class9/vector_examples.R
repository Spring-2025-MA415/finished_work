library(magrittr)

vector1 <- 1:9

# mean(vector1)

# vector1 |> mean() 

add1 <- function(x) {
  return(x+1)
}

vector1 

# vec <- vector1 |> mean() |> add1()

vector1 %<>% mean() %>% add1()



