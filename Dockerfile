FROM rocker/r-ubuntu

RUN apt-get update && apt-get install -y pandoc

RUN mkdir /project
WORKDIR /project

RUN mkdir -p code
RUN mkdir -p output
RUN mkdir -p derived_data
RUN mkdir -p output/tables
RUN mkdir -p output/figures
COPY code code
COPY Makefile .
COPY report.Rmd .

COPY .Rprofile .
COPY renv.lock .
RUN mkdir renv
COPY renv/activate.R renv
COPY renv/settings.json renv

RUN DEBIAN_FRONTEND=noninteractive 
RUN apt-get update 
RUN apt-get install -y libglpk-dev

RUN Rscript -e "renv::restore(prompt=FALSE)"

RUN mkdir report

CMD make && cp report.html report
