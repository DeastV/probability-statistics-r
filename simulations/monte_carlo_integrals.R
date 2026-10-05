# Monte Carlo Simulations and Extreme Value Theory
# Exercises 4 and 5

suppressPackageStartupMessages({
  if (!requireNamespace("extraDistr", quietly = TRUE)) {
    install.packages("extraDistr", repos = "https://cloud.r-project.org")
  }
  library(extraDistr)
})

# -------------------------------------------------------------
# Part 1: Gumbel Distribution Exceedance Simulation (Ex 4)
# -------------------------------------------------------------
cat("=== Part 1: Gumbel Extreme Value Simulation ===\n")
mu <- 3150
sigma <- 560

# Theoretical threshold and probabilities
L_A <- qgumbel(0.9, mu, sigma)
L_E <- L_A + 1000
prob_LE <- pgumbel(L_E, mu, sigma, lower.tail = FALSE)
prob_LA <- 0.1
valor_exato <- prob_LE / prob_LA

# Empirical Monte Carlo simulation
set.seed(3730)
n <- 2700
amostra <- rgumbel(n, mu, sigma)
excederam_LA <- amostra[amostra > L_A]
valor_simulado <- sum(excederam_LA > L_E) / length(excederam_LA)
quociente <- valor_simulado / valor_exato

cat("Exact probability P(X > L_E | X > L_A):", round(valor_exato, 5), "\n")
cat("Simulated probability:                 ", round(valor_simulado, 5), "\n")
cat("Simulation / Exact quotient:           ", round(quociente, 4), "\n\n")

# -------------------------------------------------------------
# Part 2: Bivariate Monte Carlo Integration (Ex 5)
# -------------------------------------------------------------
cat("=== Part 2: Bivariate Monte Carlo Integration ===\n")
funcao_integradora <- function(x) {
  (2 * x * (1 - 1.9 * x)) / (1 - x)
}

limite_sup_x <- 1 / 1.9
resultado_integral <- integrate(funcao_integradora, lower = 0, upper = limite_sup_x)
valor_exato <- resultado_integral$value

# Monte Carlo sampling: X = sqrt(U), Y = X + Z*(1-X)
set.seed(2280)
K <- 100
n_sim <- 1400
proporcoes <- numeric(K)

for (i in 1:K) {
  u <- runif(n_sim, 0, 1)
  x <- sqrt(u)
  z <- runif(n_sim, 0, 1)
  y <- x + z * (1 - x)
  sucessos <- sum(y > 1.9 * x)
  proporcoes[i] <- sucessos / n_sim
}

valor_simulado <- mean(proporcoes)
quociente <- valor_simulado / valor_exato

cat("Numerical Integration value: ", round(valor_exato, 5), "\n")
cat("Monte Carlo Simulated mean:  ", round(valor_simulado, 5), "\n")
cat("Quotient (Sim / Exact):      ", round(quociente, 4), "\n")
