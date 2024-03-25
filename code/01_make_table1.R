library(here)

here::i_am(
  "code/01_make_table1.R"
)

rna_data <- readRDS(
  file = here::here("derived_data/rna_data.rds")
)

library(gtsummary)

data <- rna_data@meta.data

data['percent10'] <- ifelse(data['percent.mt']>10, 1,0)

table_one <-  data %>% 
  select("nCount_Spatial", "nFeature_Spatial", "percent.mt", "percent10")  %>% 
  tbl_summary(
    type = list(percent10 ~ "dichotomous", all_continuous() ~ "continuous2"),
    statistic = all_continuous() ~ c(
      "{N_nonmiss}",
      "{median} ({p25}, {p75})",
      "{min}, {max}"),
    label = list(nCount_Spatial = "nCount in each spot", 
                 nFeature_Spatial = "nGene in each spot",
                 percent.mt = 'Percent of mitochondrial (MT) genes',
                 percent10 = 'MT genes > 10%'
    )) %>% 
  modify_header(label = "**Variable**") %>% 
  modify_caption("**Table 1. Spot Information Summary for Quality Control**")

saveRDS(
  table_one,
  file = here::here("output/tables/table_one.rds")
)