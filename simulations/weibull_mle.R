# Maximum Likelihood Estimation (MLE): Weibull Distribution Parameter Fitting
# Exercise 7

cat("=== Maximum Likelihood Estimation for Weibull Distribution ===\n")

amostra <- c(1.51, 3.24, 1.21, 3.32, 1.24, 1.52, 4.34, 2.52, 2.62, 1.5, 4.16, 4.43,
             0.86, 3.97, 4.61, 4.41, 2.45)
n <- length(amostra)

# Profile score equation for Weibull shape parameter alpha:
# 1/alpha + (1/n)*sum(log(x)) - sum(x^alpha * log(x)) / sum(x^alpha) = 0
eq_alpha <- function(alpha) {
  1 / alpha + sum(log(amostra)) / n - sum((amostra^alpha) * log(amostra)) / sum(amostra^alpha)
}

# Numerical root finding
resultado_uniroot <- uniroot(eq_alpha, c(1.6, 2.4))
alpha_hat <- resultado_uniroot$root

# Closed-form scale parameter estimate given shape alpha_hat
lambda_hat <- (sum(amostra^alpha_hat) / n)^(1 / alpha_hat)

# Estimated median survival / duration:
# median = lambda * (ln 2)^(1/alpha)
mediana_hat <- lambda_hat * (log(2))^(1 / alpha_hat)

cat("Sample size (n):                 ", n, "\n")
cat("MLE Shape parameter (alpha_hat): ", round(alpha_hat, 4), "\n")
cat("MLE Scale parameter (lambda_hat):", round(lambda_hat, 4), "\n")
cat("Estimated median duration:       ", round(mediana_hat, 2), "\n")
