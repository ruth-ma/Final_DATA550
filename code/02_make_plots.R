here::i_am("code/02_make_plots.R")

rna_data <- readRDS(
  file = here::here("derived_data/rna_data.rds")
)

library(ggplot2)

# scatterplot
data <- rna_data@meta.data

scatterplot <- 
  ggplot(data, aes(x = nCount_Spatial, y = nFeature_Spatial)) +
  geom_point() +
  geom_smooth(method = lm) +
  theme_bw() +
  xlab('nCount in each spot') +
  ylab('nGene in each spot') +
  ggtitle('Figure 1. The relationship between nCount and nGene in each spot') +
  labs(caption = "The blue line displays the pattern between nCount and nGene in each spot")

ggsave(
  here::here("output/figures/scatterplot.png"),
  plot = scatterplot,
  device = "png"
)

library(Seurat)
library(patchwork)

# countplot
plotV <- VlnPlot(rna_data, features = "nCount_Spatial", pt.size = 0.1) + NoLegend()
plotS <- SpatialFeaturePlot(rna_data, features = "nCount_Spatial") + theme(legend.position = "right")
countplot <- wrap_plots(plotV, plotS)

ggsave(
  here::here("output/figures/countplot.png"),
  plot = countplot,
  device = "png"
)

# featureplot
featureplot <- SpatialFeaturePlot(rna_data, features = c("Rpl7", "Gls"))

ggsave(
  here::here("output/figures/featureplot.png"),
  plot = featureplot,
  device = "png"
)