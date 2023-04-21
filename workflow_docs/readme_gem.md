## Overview of cyanophycin metabolism analysis in GEM MAGs

### Data overview
- GEM MAGs are described in this publication: [A genomic catalog of Earth's microbiomes](https://www.nature.com/articles/s41587-020-0718-6)
- GEM metadata downloaded from NSERC portal and parsed
- GEM MAG analysis performed on Northwestern Quest high performance computing cluster
- Plotting performed on my local computer with R

### Workflow
1) Download MAGs from NSERC portal to Quest
- Performed during interactive Quest session via command line
- Downloaded fna, faa, ffn tar files that contain all MAGs in GEM dataset
```
wget -r --no-parent https://portal.nersc.gov/GEM/genomes/
```

2) Parse MAGs to only include wastewater MAGs in analysis
- I split the analysis into high quality (HQ) and medium quality (MQ) MAGs (mostly to test viability of this approach on HQ MAGs only, this could have been run on all MAGs at once)
- Performed with **GEM_magparse.sh** and **GEM_magparse.py** scripts
- Medium quality MAGs were split into batches using **prokka_prep.py** but this could probably have been accomplished with an array batch script

3) Predict CDS and annotate using prokka
- Performed with **GEM_prokka.sh** scripts
- faa and ffn files from the GEM data repository are already CDS predictions from Prodigal, but the prokka annotation pipeline performs CDS prediction with Prodigal and then annotatesCDS

4) Tabulate annotations from prokka
- **prokka_parse.py** parses through tsv outputs, which provides a unique locus tag for each annotation as well as EC number and length
- **prokka_txtparse.py** parses through txt outputs, which provide CDS information
- **prokka_gffparse.py** parses through gff outputs, which provide bin and contig info associated with the locus tag

5) Compile annotations for downstream analysis
- Put everything into one file for downstream analysis with jupyter notebooks **Annotation parse.ipynb** and Excel **annotation summary.xlsx**

Visualization
- Data visualization performed with R and a variety of plotting packages in **manuscript_figures.R**
