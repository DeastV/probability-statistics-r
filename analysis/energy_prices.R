# Time-Series Analysis: YoY Relative Variation of Crude Oil Benchmarks
# Dataset: Petroleum & Other Liquid Fuels (Petroleum&OtherLiquidFuels.txt)

library(ggplot2)

# Load tab-delimited data with European decimal comma format
data_path <- file.path("data", "Petroleum&OtherLiquidFuels.txt")
if (!file.exists(data_path)) {
  data_path <- file.path("analysis", "data", "Petroleum&OtherLiquidFuels.txt")
}
dados <- read.table(data_path, header = TRUE, sep = "\t", dec = ",")
dados$Date <- as.Date(dados$Date)

# Reshape data into long format for ggplot2
dados_grafico <- data.frame(
  Date = rep(dados$Date, times = 3),
  Variation = c(dados$CrudeWTI, dados$CrudeBrent, dados$MEAN),
  Series = rep(c("CrudeWTI", "CrudeBrent", "MEAN"), each = nrow(dados))
)

# Plot YoY relative variation over time
grafico <- ggplot(dados_grafico, aes(x = Date, y = Variation, color = Series)) +
  geom_line(linewidth = 0.7, alpha = 0.8) +
  scale_color_manual(
    values = c("CrudeWTI" = "#1f77b4", "CrudeBrent" = "#d62728", "MEAN" = "#2ca02c")
  ) +
  labs(
    title = "YoY Price Variation Over Time",
    subtitle = "Comparing CrudeWTI, CrudeBrent and the overall MEAN",
    x = "Date",
    y = "YoY Relative Variation",
    color = "Series"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5),
    legend.position = "bottom"
  )

# Render plot
print(grafico)
