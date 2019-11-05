# CRISPR Spacer Database
Spacer database to infer host-virus interactions

## Database Compilation

CRISPR spacers were compiled from four distinct sources (1) the [CRISPRCasdb](https://crisprcas.i2bc.paris-saclay.fr/Home/Download), built using [CRISPRCasFinder](https://academic.oup.com/nar/article/46/W1/W246/5001162) completely assembled genomes from RefSeq, (2) [a set of spacers](https://www.liebertpub.com/doi/full/10.1089/crispr.2018.0034) built using [CRISPRDetect](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4869251/) on all prokaryotic assemblies in NCBI's RefSeq (December, 2017), (3) a set of spacers found in [24345 high-quality metagenome assembled genomes](https://www.nature.com/articles/s41586-019-1058-x) (MAGs) from the human microbiome using [MinCED](https://github.com/ctSkennerton/minced) (based on [CRT](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-8-209)), (4) a set of spacers from the 24706 species-representative sequences in [GTDB](https://www.biorxiv.org/content/10.1101/771964v1) found using MinCED, (5) a set of spacers found on [3000 diverse assmbled metagenomes](https://www.mdpi.com/2073-4425/10/9/714) using MinCED. In total this resulted in ???? unique spacer sequences across ???? species and/or metagenome contigs. 

## Target Discovery in 3000 Metagenomes

Using a set of [3000 diverse assmbled metagenomes](https://www.mdpi.com/2073-4425/10/9/714), we used BLAST to discover sequences targeted by known spacers in our database. Targeted contigs were then assessed to determine whether they were  viral (how??? - other groups).

## Validation of Spacers to Discover Host Identity

We used BLAST to match spacers in our database to known viral sequences with known hosts (other group half ????). We then compared spacers source taxon identity to known host taxon to determine how reliably spacer-based host prediction matched our known links in the database.