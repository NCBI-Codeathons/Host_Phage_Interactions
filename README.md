# Host Phage Interactions
Linking Phages to Microbial Hosts

### Hosts (black circles) Linked to Viruses (red circles)

![alt_text](https://github.com/NCBI-Codeathons/Host_Phage_Interactions/blob/development/images/bipartite_hotsvir_circle.png)

## Viruses As Indeces For NCBI SRA Metagenomes

Viruses that infect microbes (both Bacteria and Archaea) have a direct impact on the organisms present in all microbiomes, regardless of environment. Like the microbiome, viruses present in a sample can be diagnostic of the conditions (e.g., microbial community structure, underlying physiochemical conditions, etc.), but unlike the microbial hosts, viruses have smaller genomes that may more easily assemble in a metagenomic sample. Indexing metagenomic samples on the viral community will provide a way categorize metagenomic samples in NCBI SRA that will allow for the identification of related sample types. The term phage specifically refers to viruses that infect bacteria.

## Detecting Host and Phage Signatures

![alt text](https://github.com/NCBI-Codeathons/Host_Phage_Interactions/blob/development/images/Flow.jpg)

The Host Phage Interaction (HPI) group developed three tracks and databases to explore the nature of host-phage interactions, specifically:

 - Known Host-Virus Interactions Database, detailing the current known linkages of infection, collected from NCBI
 - CRISPR Spacer Database, constructed by extracting spacer information from CRISPR arrays representing a large breadth of microorganisms 
 - E. coli Prophage Virulence Factor Database, a collection of clinical and environmental E. coli screened for prophage sequences and corresponding bacterial virulence factors

## Known Host-Virus Interactions Database

Existing databases providing information on hosts (including Bacteria, Archaea, and Eukarya) and the identity of confirmed viral agents were gathered from [PhagesDB](https://phagesdb.org/) and NCBI VirusHostDB/NCBI Virus-Host Database (CITE) were combined and standardized.

The comprehensive database table consists of 44,975 virus-host pairs. The number of unique viruses and hosts in the database are 29,847 and 7,974, respectively.

The database can be accessed in `KnownInteractionsDB.csv`

![alt_text](https://github.com/NCBI-Codeathons/Host_Phage_Interactions/blob/development/images/KnownInteractionDB.png)

## CRISPR Spacer Database

CRISPR-Cas adaptive immune systems are a unique form of [adaptive immunity](https://science.sciencemag.org/content/315/5819/1709) found in prokaryotes wherein [viral DNA or RNA sequences are stored on the host genome in the form of short (~30bp) "spacers"](https://link.springer.com/article/10.1007/s00239-004-0046-3). [These spacers, stored at a repetitive CRISPR "array" can be used to reliably associate viruses with their hosts](https://academic.oup.com/femsre/article/40/2/258/2570202). This approach, though precise, will inevitably miss host-virus pairs where the host lacks a CRISPR array ( [a majority of bacteria](https://www.nature.com/articles/nrmicro3569), [especially certain groups](https://www.nature.com/articles/ncomms10613?origin=ppub)), or where the diversity of host CRISPR spacers has been inadequately profiled. Nevetheless, this method [can give highly confident host-virus pairs when a perfect match is found](https://academic.oup.com/femsre/article/40/2/258/2570202).

CRISPR spacers were compiled from four distinct sources: 
 - (1) the [CRISPRCasdb](https://crisprcas.i2bc.paris-saclay.fr/Home/Download), built using [CRISPRCasFinder](https://academic.oup.com/nar/article/46/W1/W246/5001162) completely assembled genomes from RefSeq = CRISPcasdb
 - (2) [a set of spacers](https://www.liebertpub.com/doi/full/10.1089/crispr.2018.0034) built using [CRISPRDetect](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4869251/) on all prokaryotic assemblies in NCBI's RefSeq (December, 2017) = RefSeqAllWeissmanetal 
 - (3) a set of spacers found in [24345 high-quality metagenome assembled genomes](https://www.nature.com/articles/s41586-019-1058-x) (MAGs) from the human microbiome using [MinCED](https://github.com/ctSkennerton/minced) (based on [CRT](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-8-209)) = MAGSNayfachetal
 - (4) a set of spacers from the 24706 species-representative sequences in [GTDB](https://www.biorxiv.org/content/10.1101/771964v1) found using MinCED. = GTDB

 All genomes/MAGs were provided a standardized taxonomy based on the [GTDB taxonomy](https://gtdb.ecogenomic.org/). 

 In total this resulted in 1M unique spacer sequences (2.6M non-redundant spacer sequences) linked to a formalized source taxonomy.

 ![alt_text](https://github.com/NCBI-Codeathons/Host_Phage_Interactions/blob/development/images/Spacer-Distribution-From-Source.png)
 ![alt_text](https://github.com/NCBI-Codeathons/Host_Phage_Interactions/blob/development/images/Spacer-Taxon-Origin-Class.png)

## E. coli Prophage Virulence Factor Database  

Members of the "E. coli and Shigella" tax group were selected from the [NCBI Pathogen Database via the Isolates Browser](https://www.ncbi.nlm.nih.gov/pathogens/isolates/#/search/taxgroup_name:%22E.coli%20and%20Shigella%22). A subset of 10,000 genomes were identified based on the filters "Host:Human" or "Host:Homo sapiens", "Isolation type:clinical" or "Isolation type:environmental/other", and "Scientific Name:Escherichia coli". Separated into two groups, "environmental" and "clinical", genomes were sorted by GenBank Assembly ID and 3,500 genomes were downloaded for each group. Genomes were downloaded using the R script `ecoli_download_links.R` and requires [pathogens_combined_table.csv](https://github.com/NCBI-Codeathons/Host_Phage_Interactions/blob/development/data/pathogens_combined_table.csv) and assembly_summary_genbank.txt, which can be accessed directly from NCBI `wget ftp://ftp.ncbi.nlm.nih.gov/genomes/genbank/assembly_summary_genbank.txt` (~100MB)


[VirSorter v1.0.5](https://github.com/simroux/VirSorter) was applied to all E. coli genomes to detect prophage integrated into the genome with the parameters `--db 2`. Detected prophages were annotated using [Prokka v1.14.0](https://github.com/tseemann/prokka) with the an additional database created from the [PARTIC database v3.5.43](https://www.patricbrc.org/) to target bacterial virulence factors, including ARDB, CARD, NDARO, PATRIC_VF, TCDB, VFDB, and Victors.

![alt_text](https://github.com/NCBI-Codeathons/Host_Phage_Interactions/blob/development/images/ProphagePipeline.jpg)


# Procedures and Results

## Target Discovery in NCBI Assembled Metagenomes

The CRISPR Spacer Database was used to search 2,953 assembled metagenomes subsampled from the NCBI SRA using BLASTn. Matches to spacers were extracted as assemblies of interest.

A combined BLAST database was constructed from the assembled metagenomes `makeblastdb -in mg_assemblies.fa -dbtype nucl -title mg_assemblies -out mg_assemblies`

The BLASTn search was parallelized using [GNU parallel](https://www.gnu.org/software/parallel/) `parallel --block 100k --recstart '>' --pipe` with the BLAST specific parameters `-task blastn-short -evalue 0.01 -outfmt 6 -gapopen 10 -gapextend 2 -penalty "-1" -word_size 7 -dust no -db mg_assemblies` adjusted to account for the short length of the spacer sequences.

```
cat spacer_db.fasta \
| parallel --block 100k --recstart '>' --pipe \
blastn \
  -task blastn-short \
  -evalue 0.01 \
  -outfmt 6 \
  -gapopen 10 \
  -gapextend 2 \
  -penalty "-1" \
  -word_size 7 \
  -dust no \
  -db mg_assemblies/blastdb/mg_assemblies -query - \
```

![alt_text](https://github.com/NCBI-Codeathons/Host_Phage_Interactions/blob/development/images/HPI-CRISPR-DB-Workflow2.png)

## CRISPR Spacer Database Matched to Known Viruses

The CRISPR Spacer Database was used to search against two known virus databases that consisted of [NCBI Viral RefSeq representatives](https://www.ncbi.nlm.nih.gov/genome/viruses/) and [NCBI Validated Virus Resource from GenBank](https://www.ncbi.nlm.nih.gov/labs/virus/vssi/#/). The BLASTn search used the same parameters as described above.

The CRISPR spacers matched X viruses in these representative databases. Cross-referenced to the known host-virus interaction database, X% matched virus-host and spacer-source.

## Clinical and Environmental E. coli Virulence Factor Occurrence 

# Expanding the CRISPR Spacer Database

Search through novel genomes to detect additional CRISPR spacer host links `minced -spacers -gffFull NAME.fasta NAME.crisprs NAME.gff`


More to come.

### Zendo DOI
