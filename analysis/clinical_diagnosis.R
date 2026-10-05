# Exploratory Data Analysis: Alkaline Phosphatase (ALP) across HCV Clinical Categories
# Dataset: HCV Clinical Diagnostic Data (hcvdat0.csv)

library(ggplot2)

# Load data with relative path
data_path <- file.path("data", "hcvdat0.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("analysis", "data", "hcvdat0.csv")
}
dados <- read.csv(data_path)

# Generate boxplot visualization across diagnosis categories
grafico <- ggplot(dados, aes(x = Category, y = ALP, fill = Category)) +
  geom_boxplot(na.rm = TRUE) +
  labs(
    title = "Distribution of ALP across Clinical Categories",
    x = "Clinical Diagnosis (Category)",
    y = "Alkaline Phosphatase (ALP)"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "none",
    plot.title = element_text(hjust = 0.5, face = "bold")
  )

# Render plot
print(grafico)
