# Statistical Inference: Exact vs Asymptotic Confidence Intervals
# Exercise 8

cat("=== Exact (Chi-Square) vs Asymptotic (Normal) Confidence Intervals ===\n")

set.seed(5131)
m <- 1200         # Number of Monte Carlo samples
n <- 21           # Sample size
lambda <- 13      # True parameter (rate = 1/lambda)
gamma <- 0.92     # Confidence level (1 - alpha)
alpha <- 1 - gamma

# Generate m samples of size n from Exp(rate = 1/lambda)
amostras <- matrix(rexp(m * n, rate = 1 / lambda), nrow = n, ncol = m)
medias_amostrais <- colMeans(amostras)

# 1. Exact Confidence Interval based on Chi-Square distribution (2*n*X_bar / lambda ~ ChiSquare(2*n))
q_chi_inf <- qchisq(alpha / 2, 2 * n)
q_chi_sup <- qchisq(1 - alpha / 2, 2 * n)
LI_1 <- (2 * n * medias_amostrais) / q_chi_sup
LS_1 <- (2 * n * medias_amostrais) / q_chi_inf
p1 <- sum(lambda >= LI_1 & lambda <= LS_1) / m

# 2. Asymptotic Confidence Interval based on Central Limit Theorem (Standard Normal Z)
z <- qnorm(1 - alpha / 2)
LI_2 <- medias_amostrais / (1 + z / sqrt(n))
LS_2 <- medias_amostrais / (1 - z / sqrt(n))
p2 <- sum(lambda >= LI_2 & lambda <= LS_2) / m

quociente <- p1 / p2

cat("Target Confidence Level (gamma):     ", gamma, "\n")
cat("Exact Chi-Square empirical coverage: ", round(p1, 5), "\n")
cat("Asymptotic Normal empirical coverage:", round(p2, 5), "\n")
cat("Coverage ratio (Exact / Asymptotic): ", round(quociente, 4), "\n")
