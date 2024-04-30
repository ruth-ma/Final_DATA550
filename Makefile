# Report-associated rules (run on Docker container)
report: report.html

report.html: report.Rmd code/03_render_report.R derived_data/rna_data.rds output/tables/table_one.rds output/figures/scatterplot.png output/figures/countplot.png output/figures/featureplot.png
	Rscript code/03_render_report.R
	
derived_data/rna_data.rds: code/00_read_data.Rmd
	Rscript -e "rmarkdown::render('code/00_read_data.Rmd')"
	
output/tables/table_one.rds: derived_data/rna_data.rds code/01_make_table1.R
	Rscript code/01_make_table1.R
  
output/figures/scatterplot.png output/figures/countplot.png output/figures/featureplot.png: derived_data/rna_data.rds code/02_make_plots.R
	Rscript code/02_make_plots.R
	
.PHONY: clean
clean:
	rm -f output/tables/*.rds && rm -f output/figures/*.png && rm -f report.html && rm -f derived_data/*.rds
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt=FALSE)"
	
# Docker-associated rules (run on our local machine)
PROJECTFILES = report.Rmd code/01_make_table1.R code/02_make_plots.R Makefile
REVFILES = renv.lock renv/activate.R renv/settings.json

# Rule to build image
project_image: Dockerfile	$(PROJECTFILES)	$(RENVFILES)
	docker build -t ru3ma/project_image .
	touch $@
	
# Rule to build the report automatically
Windows_report:
	docker run -v /"$$(pwd)/report":/project/report ru3ma/project_image
	
MacLinux_report:
	docker run -v "$$(pwd)/report":/project/report ru3ma/project_image
