library("tidyverse")
theme_set(theme_bw())
library("plotly")

source("R/read_data.R")

# Plot tests
g <- ggplot(
  tests |>
    filter(Competition == "Yes"),
  aes(x = `Test Date`, y = `Capacity Ah`, color = Battery, linetype = Age)
) +
  geom_line()

ggplotly(g)


# Winona analysis
sm <- comps |>
  pivot_longer(
    cols = starts_with("Voltage"),
    names_to = "when",
    values_to = "voltage"
  ) |>
  mutate(
    when = gsub("Voltage @ 18 A ", "", when),
    when = factor(when, levels = c("Before", "After")),

    voltage = as.numeric(voltage)
  )

ggplot(
  sm,
  aes(x = when, y = voltage, color = Battery, group = key, shape = Battery)
) +
  geom_line() +
  geom_point()

#
comps |>
  group_by(Battery) |>
  summarize(
    n = n(),
    n_na = n - sum(!is.na(voltage_drop)),
    mean = mean(voltage_drop, na.rm = TRUE),
    sd = sd(voltage_drop, na.rm = TRUE)
  ) |>
  arrange(mean)
