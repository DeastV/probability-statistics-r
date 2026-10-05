# Goodness-of-Fit Testing: Chi-Square Test with Sturges and Freedman-Diaconis Binning
# Exercise 10

cat("=== Chi-Square Goodness-of-Fit Test on Real Data ===\n")

# Locate data file
data_path <- file.path("data", "Modular_P800.txt")
if (!file.exists(data_path)) {
  data_path <- file.path("simulations", "data", "Modular_P800.txt")
}
dados_totais <- scan(data_path, quiet = TRUE)

# Draw reproducible sub-sample (75% of dataset)
set.seed(5378)
n_sub <- round(0.75 * length(dados_totais))
subamostra <- sample(dados_totais, size = n_sub, replace = FALSE)

# Binning rules
k_Sturges <- nclass.Sturges(subamostra)
k_FD <- nclass.FD(subamostra)

# Target distribution under H0: Normal(mu = 0, sigma^2 = 1.96)
mu_0 <- 0
sigma_0 <- sqrt(1.96)

# Chi-Square test function for equiprobable class intervals
calcula_pvalor <- function(k, amostra) {
  limites <- qnorm((0:k) / k, mean = mu_0, sd = sigma_0)
  frequencias_observadas <- as.numeric(table(cut(amostra, breaks = limites, include.lowest = TRUE)))
  frequencias_esperadas <- length(amostra) / k
  estatistica_chi <- sum((frequencias_observadas - frequencias_esperadas)^2 / frequencias_esperadas)
  graus_liberdade <- k - 1
  pchisq(estatistica_chi, df = graus_liberdade, lower.tail = FALSE)
}

p_valor_Sturges <- calcula_pvalor(k_Sturges, subamostra)
p_valor_FD <- calcula_pvalor(k_FD, subamostra)
p_max <- max(p_valor_Sturges, p_valor_FD)
p_min <- min(p_valor_Sturges, p_valor_FD)
quociente <- p_max / p_min

cat("Sample size (subsample):       ", length(subamostra), "\n")
cat("Sturges rule bins (k):         ", k_Sturges, " | p-value:", round(p_valor_Sturges, 5), "\n")
cat("Freedman-Diaconis bins (k):    ", k_FD, " | p-value:", round(p_valor_FD, 5), "\n")
cat("Ratio of max to min p-value:   ", round(quociente, 4), "\n")
