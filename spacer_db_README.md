# CRISPR Spacer Database

Database of known CRISPR spacers and their host taxonomy from various sources:  
(1) the [CRISPRCasdb](https://crisprcas.i2bc.paris-saclay.fr/Home/Download), built using [CRISPRCasFinder](https://academic.oup.com/nar/article/46/W1/W246/5001162) completely assembled genomes from RefSeq  
(2) [a set of spacers](https://www.liebertpub.com/doi/full/10.1089/crispr.2018.0034) built using [CRISPRDetect](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4869251/) on all prokaryotic assemblies in NCBI's RefSeq (December, 2017)  
(3) a set of spacers found in [24345 high-quality metagenome assembled genomes](https://www.nature.com/articles/s41586-019-1058-x) (MAGs) from the human microbiome using [MinCED](https://github.com/ctSkennerton/minced) (based on [CRT](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-8-209))  
(4) a set of spacers from the 24706 species-representative sequences in [GTDB](https://www.biorxiv.org/content/10.1101/771964v1) found using MinCED  

## Data Columns

Accession: contig accession that CRISPR array is found on  
ArrayID: id of array (when more than one found on genome)  
SpacerID: location of spacer in CRISPR array  
SpacerSeq: sequence of spacer (used to match w/ virus)  
Accession3: genome accession  
TaxonomyGTDB: Host lineage from GTDB  
Source: data source  
  
Most important columns are SpacerSeq, TaxonomyGTDB, and source (and the accession are probably also useful)