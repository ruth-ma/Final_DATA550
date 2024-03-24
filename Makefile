report: report.Rmd code/03_render_report.R output/tables/table_one.rds output/figures/scatterplot.png output/figures/countplot.png output/figures/featureplot.png
	Rscript code/03_render_report.R
	
derived_data: code/00_read_data.Rmd
	Rscript code/00_read_data.Rmd
	
tables: derived_data/rna_data.rds 01_make_table1.R
	Rscript code/01_make_table1.R
  
figures: derived_data/rna_data.rds code/02_make_plots.R
	Rscript code/02_make_plots.R
	
.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f report.html