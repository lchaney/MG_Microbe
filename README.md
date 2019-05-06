#Altering the microbial soil community changes the patterns of selection on plant growth and fitness related traits

[Lindsay Chaney] (http://www.lindsaychaney.com), and [Gina Baucom] (http://sites.lsa.umich.edu/baucom-lab/)

This repository contains all the code used in the manuscript:

enter citation here

**Abstract:** Soil microbial communities are diverse and have a large impact, both positive and negative, on the host plant. However, the impact of the soil microbial community on a plants evolutionary responses is not well understood. Here we sought to uncover if below-ground microbial communities influence patterns of selection in a plant community. To do this, a common-greenhouse experiment was used where soil microbial community was disrupted by either sterilizing (autoclaving) or sterilizing and re-inoculating with the microbial community from originally collected field soil. We found that a more complex soil microbial community resulted in a larger plant size and higher number of total number of flowers produced. Patterns of selection for flowering day differed based off of soil microbial community, selection more strongly favored earlier flowering when in the complex microbial environment. Further we see differences in correlated selection by soil microbial community. Selection favored faster growth and mid- to early-flowering in simple soil microbial community but medium growth and mid to early flowering in the complex soil microbial community. Together these results suggest the soil microbial community is a selective agent and that soil microbial community influences evolutionary processes.

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

Figures generated in R will be saved as `.png` files in a folder called Output.

###Report of R figures and results

To reproduce R figures and results from statistical analysis, a html report is created using markdown (`MG_Microbe.Rmd`).

To run the report in RStudio the “Knit” command (Ctrl+Shift+K) will render the document and display a preview of it.

## Citation

For archival purposes, the code used to produce figures for publication has been lodged with figshare here (link).

To cite this code:

```
citation
```
