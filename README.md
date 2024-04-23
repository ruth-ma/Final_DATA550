# Clone the github repository

Change the current working directory to the location where you want the cloned directory.

- In terminal, run `git clone https://github.com/ruth-ma/Final_DATA550`.

- Please make sure the working directory is "~/Final_DATA550-master" in R console, use the following command: `setwd("~/Final_DATA550-master")`.

- Please make sure the working directory is "~/Final_DATA550-master" in the bash terminal, use the `cd` command.

# Build a local Docker image or download from Dockerhub

- Download from Dockerhub: in terminal, run `docker pull ru3ma/project_image`. You could also find the Docker image at: https://hub.docker.com/repository/docker/ru3ma/project_image/general

Or

- Build by yourself: in terminal, run `docker build -t ru3ma/project_image.` or using `make project_image`.

# How to create the report using Docker

- To utilize Docker for generating the report, run the following command in the terminal:\
For Windows-OS users:\
`docker run -v /"$(pwd)/report":/project/report ru3ma/project_image`\
For Mac/Linux-OS users:\
`docker run -v "$(pwd)/report":/project/report ru3ma/project_image`

Or

- Use `make` in the terminal to simplify the process of running all codes and generating the report file.\
For Windows-OS users:\
`make windows_report`\
For Mac/Linux-OS users:\
`make MacLinux_report`

It takes more than 10 minutes to download and install the dataset. Be patient!

You will find `report.html` file in the local `report` folder.

# How to run the program not using Docker
If this is your first time working with RNA data, the initial setup may take a few minutes as you install necessary packages.

- Please use the `make install` in the terminal to synchronize your package repository. Do not suggest use `renv::restore()` in R console, because it might have some issues.

- Use `make` in the terminal to simplify the process of running all codes and generating the report file.

All code files are located in the 'code' folder. If you're unfamiliar with 'make', you can __run the files individually starting with '00_read_data.Rmd', followed by '01_make_table1.R', '02_make_plots.R', and finally '03_render_report.R'__.

Tables and plots will be generated in the 'output' folder, while the final report will be found in the main folder.

Traditionally, tables are not the preferred method for visualizing gene data. Nonetheless, in adherence to assignment requirements, we will include tables to represent the gene data.

# About the dataset
Feel free to skip this section if the scientific background doesn't interest you.

This is a spatial transcriptomics dataset.  
The dataset comprises spatial transcriptomics information within a mouse brain and is stored as a Seurat object. It includes counts information, representing RNA counts or gene expression in each spot, as well as coordinate information, indicating the physical coordinates of each spot.
Exploring the dataset enables us to grasp the spatial intricacies within the mouse brain, identifying key genes prevalent in each distinct brain region, and subsequently establishing connections between gene expression patterns and brain functionality.

*Note*:

Please be patient while working with the dataset; the data is high-dimensional and processing may be slow.

You have several ways to read in the dataset.  
1. Using the 10X function to read in the dataset (recommend).  
2. Download the dataset from [https://www.10xgenomics.com/datasets/mouse-brain-serial-section-2-sagittal-posterior-1-standard-1-0-0](10X website) and read in the local dataset. At least "Feature/barcode matrix HDF5 (filtered)" and "Spatial imaging data" should be downloaded.

# Code Description

`code/00_read_data.R`
- read raw data from online or `raw_data/` folder
- save clean data in `derived_data/` folder

`code/01_make_table1.R`
- read clean data from `derived_data/` folder
- save table 1 in `output/tables/` folder

`code/02_make_plots.R`
- read clean data from `derived_data/` folder
- save scatter plot in `output/figures/` folder

`code/03_render_report.R`
- render `report.Rmd` 
- save compiled report in main folder

`code/report.Rmd`
- read data, tables, and figures from respective locations
- display results for production report