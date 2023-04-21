## Overview of metatranscriptomic analysis workflow for PAO-enriched bioreactor datasets

### Datasets
wang2021
- Paper: [Integrated omics analyses reveal differential gene expression and potential for cooperation between denitrifying polyphosphate and glycogen accumulating organisms](https://sfamjournals.onlinelibrary.wiley.com/doi/10.1111/1462-2920.15486)
- Description: CANDO+P reactor with time series transcripts of anaerobic-anoxic-aerobic cycle with acetate and propionate

mcdaniel2021
- Paper: [Metabolic Differentiation of Co-occurring Accumulibacter Clades Revealed through Genome-Resolved Metatranscriptomics](https://journals.asm.org/doi/10.1128/mSystems.00474-21)
- Description: EBPR reactor with reactor cycle time series of anaerobic-aerobic cycle
- Metadata retrieved from [project repository](https://github.com/elizabethmcd/R3R4)


### Workflow
- Download MAGs and raw transcript reads from NCBI -  fasterqdump.sh
- Clean transcript reads with fastp using default settings - fastp.sh
- Annotate MAGs with prokka using default settings - prokka.sh
- Concat .ffn results (CDS regions) from prokka and create kallisto index - kallisto_index.sh
- Use bbduk and SILVA reference database to remove 16s rRNA reads - bbduk.sh
- Run kallisto on reads and index to get count tables - kallisto_quant.sh
- Concat prokka outputs and analyze count tables in R locally
