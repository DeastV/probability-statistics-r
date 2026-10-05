# Statistical Hypothesis Testing: Power and Type II Error (Beta) Estimation
# Exercise 9

cat("=== Hypothesis Testing: Type II Error Estimation in Beta Distributions ===\n")

# Distribution parameters under H0 and H1
b <- 3
n <- 32
alpha <- 0.01

# Null hypothesis H0: a = a0 = 2
a0 <- 2
mu0 <- a0 / (a0 + b)
var0 <- (a0 * b) / (((a0 + b)^2) * (a0 + b + 1))
sigma0 <- sqrt(var0)

# Alternative hypothesis H1: a = a1 = 2.35
a1 <- 2.35
mu1 <- a1 / (a1 + b)
var1 <- (a1 * b) / (((a1 + b)^2) * (a1 + b + 1))
sigma1 <- sqrt(var1)

# Critical value under H0 for significance alpha
z_alpha <- qnorm(1 - alpha)
c_xbar <- mu0 + z_alpha * sigma0 / sqrt(n)

# Theoretical Type II Error probability (beta): P(Fail to reject H0 | H1 is true)
beta_prob <- pnorm(c_xbar, mean = mu1, sd = sigma1 / sqrt(n))

# Empirical Monte Carlo simulation of test statistic under H1
set.seed(817)
m <- 2000
amostras <- matrix(rbeta(m * n, shape1 = a1, shape2 = b), nrow = n, ncol = m)
medias_amostrais <- colMeans(amostras)
Z0_sim <- (medias_amostrais - mu0) / (sigma0 / sqrt(n))
nao_rejeicoes <- sum(Z0_sim <= z_alpha)
beta_hat <- nao_rejeicoes / m

quociente <- beta_hat / beta_prob

cat("Significance level (alpha):        ", alpha, "\n")
cat("Theoretical Type II Error (beta):  ", round(beta_prob, 5), "\n")
cat("Empirical Type II Error (beta_hat):", round(beta_hat, 5), "\n")
cat("Simulated / Theoretical quotient:  ", round(quociente, 4), "\n")
