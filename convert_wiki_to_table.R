library(tidyverse)

raw <- readLines("raw_data.txt")

provincies <- str_split(raw, " ") %>% map_chr(~.x[[length(.x)]])

postcodes <- str_extract_all(raw, "\\d{4}") %>%
  map(as.numeric) %>%
  map(function(x) {
    if (length(x) == 2) {
      x[1]:x[2]
    } else {
      x
    }
  })

table <- map2_dfr(postcodes, provincies, ~tibble(pc4 = .x, provincie = .y))

write_csv(table, "pc4_provincie_mapping.txt")
