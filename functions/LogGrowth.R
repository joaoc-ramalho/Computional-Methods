logGrowth <- function(t, y, p) {
  N <- y[1]
  with(as.list(p), { #"with all the 'p' values"
    dN.dt <- r * N * (1 - a * N)
    return(list(dN.dt))
  })
}

# We are putting as arguments the time (t), initial conditions (y), and
# parameters/variables (p)

#"with" will cycle all the parameters in "p"
