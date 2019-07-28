# The soil microbial community alters patterns of selection on flowering time and fitness related traits in *Ipomoea purpurea*

[Lindsay Chaney](http://www.lindsaychaney.com), and [Regina S. Baucom](http://sites.lsa.umich.edu/baucom-lab/)

This repository contains all the code used in the manuscript:

```
enter citation here
```

**Abstract:** 
*Plant flowering time plays an important role in plant fitness and thus evolutionary processes. Soil microbial communities are diverse and have a large impact, both positive and negative, on the host plant. However, owing to few available studies, how the soil microbial community may influence the evolutionary response of plant populations is not well understood. Here we sought to uncover if below-ground microbial communities act as an agent of selection on flowering and growth traits in the common morning glory, _Ipomoea purpurea_. 
*We performed a controlled greenhouse experiment in which genetic lines of _I. purpurea_ were planted into either sterilized soils, or soils that were sterilized and re-inoculated with the microbial community from original field soil. This allowed us to directly test the influence of alterations to the microbial community on plant growth, flowering, and fitness, as well as assess patterns of selection in both soil microbial environments.
*We found that a more complex soil microbial community resulted in larger plant size and greater number of flowers produced. Selection strongly favored earlier flowering when plants were grown in the complex microbial environment than compared to sterilized soil. Additionally, we uncovered a pattern of negative correlational selection on growth rate and flowering time indicating that selection favored different combinations of growth and flowering traits in the simplified versus complex soil community.  
*Together these results suggest the soil microbial community is a selective agent on flowering time and ultimately that soil microbial community influences important plant evolutionary processes.

**Key Words**
phenology, growth, agent of selection, microbiome, soil, *Ipomoea purpurea*

## Data

Data has been archived for public access at Dryad (link)

_Temporarily the data has be achieved here on GitHub in the data folder_**

To cite this data:

```
data citation
```

## Running

Download zip of the entire repository. This will be the parent folder and your working directly to run the analysis and/or produce the markdown page. Download data files (one .csv file from Dryad - file is titled `mgdat.csv`) and place into a folder titled `Data` within the parent directory. Remember, you need to set your working 
directory to the location that contains the folders "Data" and "Analysis".

From your R console, source the Do script (`Analysis/04_do.R`), this will perform all analysis.

This script sources scripts to Load data (`01_Load.R`, including installing and loading packages), to Clean data (`02_Clean.R`) and to perform analyses (`03_Func.R`) [Note that the Functions script has been broken up for each different part of the analysis.

Figures generated in R will be saved as `.png` files in a folder called Output.

## Citation

For archival purposes, the code used to produce figures for publication has been lodged with figshare here (link).

To cite this code:

```
citation
```
