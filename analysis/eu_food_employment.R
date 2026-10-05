# Comparative Analysis: Employment in the Food Industry (Croatia vs Estonia)
# Dataset: European Union Jobs and Growth (Jobs_and_Growth.csv)

library(ggplot2)

# Load data with original column names preserved
data_path <- file.path("data", "Jobs_and_Growth.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("analysis", "data", "Jobs_and_Growth.csv")
}
dados <- read.csv(data_path, check.names = FALSE)

# Filter for target countries and sub-indicator
condicao_pais <- dados[["Member State Name"]] %in% c("Croatia", "Estonia")
condicao_indicador <- dados[["Sub-indicator Name"]] == "Employment in the food industry"
dados_filtrados <- dados[condicao_pais & condicao_indicador, ]

# Generate grouped bar chart over time
grafico <- ggplot(dados_filtrados, aes(x = factor(`Time Period`), y = Data, fill = `Member State Name`)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  labs(
    title = "Evolution of Employment in the Food Industry",
    subtitle = "Comparing Croatia and Estonia over time",
    x = "Year",
    y = "Employment (thousands)",
    fill = "Country"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "bottom"
  )

# Render plot
print(grafico)
