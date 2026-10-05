# Central Limit Theorem (TLC): Poisson Convergence Analysis
# Exercise 6

cat("=== Central Limit Theorem Simulation for Poisson Distribution ===\n")

set.seed(2034)
M <- 153          # Number of Monte Carlo replications
n <- 336          # Sample size per replication
lambda <- 2       # Poisson parameter (E[X] = Var[X] = lambda)
epsilon <- 0.16   # Deviation threshold

# Empirical replication of sample means
medias_amostrais <- replicate(M, mean(rpois(n, lambda)))
resultado_frequentista <- sum(abs(medias_amostrais - lambda) <= epsilon) / M

# Asymptotic approximation via Central Limit Theorem:
# X_bar ~ N(lambda, lambda / n)
desvio_padrao_Xbar <- sqrt(lambda / n)
resultado_tlc <- pnorm(lambda + epsilon, mean = lambda, sd = desvio_padrao_Xbar) -
  pnorm(lambda - epsilon, mean = lambda, sd = desvio_padrao_Xbar)

quociente <- resultado_frequentista / resultado_tlc

cat("Sample size (n):                    ", n, "\n")
cat("Replications (M):                   ", M, "\n")
cat("Frequentist simulated probability:  ", round(resultado_frequentista, 5), "\n")
cat("Theoretical asymptotic TLC prob:    ", round(resultado_tlc, 5), "\n")
cat("Quotient (Frequentist / TLC):       ", round(quociente, 4), "\n")
