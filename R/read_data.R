library("tidyverse")
library("readxl")

file2025 <- "data/Battery Test results 2024 2025 --.xlsx"
file2026 <- "data/Battery Test Results 2025-2026 Season.xlsx"

meta <- read_excel(file2026, sheet = "Metadata") |>
  select(Battery, Age, Competition)

tests <- read_excel(file2026, sheet = "Battery Test Results") |>
  left_join(meta, by = join_by(Battery))
comps <- read_excel(file2026, sheet = "Competition Log") |>
  left_join(meta, by = join_by(Battery)) |>
  mutate(voltage_drop = `Voltage @ 18 A Before` - `Voltage @ 18 A After`)
