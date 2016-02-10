#Altering the microbial soil community changes the patterns of selection on plant growth and fitness related traits

[Lindsay Chaney] (http://www.lindsaychaney.com), Laurie Elliott, Deborah LeGendgre, and [Gina Baucom] (http://sites.lsa.umich.edu/baucom-lab/)

This repository contains all the code used in the manuscript:

enter citation here

**Abstract:** Abstract text here.

##Data

Data has been archived for public access at Dryad (link)

To cite this data:

```
data citation
```

##Running

Download zip of the entire repository. This will be the parent folder and your working directly to run the analysis and/or produce the markdown page. Download data files (one .csv file from Dryad) and place into a folder titled `Data` within the parent directory. Remember, you need to set your working 
directory to the location that contains the folders "Data" and "Analysis".

From your R console, source the Do script (`Analysis/04_do.R`), this will perform all analysis.

This script sources scripts to Load data (`01_Load.R`, including installing and loading packages), to Clean data (`02_Clean.R`) and to perform analyses (`03_Func.R`) [Note that the Functions script has been broken up for each different part of the analysis.

Figures generated in R will be saved as `.png` files in a folder called Output. **Not Added yet**

###Report of R figures and results

To reproduce R figures and results from statistical analysis, a html report is created using markdown (`MG_Microbe.Rmd`).

To run the report in RStudio the “Knit” command (Ctrl+Shift+K) will render the document and display a preview of it.

## Citation

For archival purposes, the code used to produce figures for publication has been lodged with figshare here (link).

To cite this code:

```
citation
```
