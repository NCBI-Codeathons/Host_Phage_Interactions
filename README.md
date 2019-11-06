# Host Phage Interactions
Understanding How Phages Affect Microbial Disease





### You can make a free DOI with zenodo <link>

## Website (if applicable)

## Intro statement

Viruses that infect microbes (both Bacteria and Archaea), commonly known as phage, have a direct impact on the organisms present in all microbiomes, regardless of environment. Like the microbiome, phage present in a sample can be diagnostic of the conditions (e.g., microbial community structure, underlying physiochemical conditions, etc.), but unlike the microbial hosts have smaller genomes that may more easily assemble in a metagenomic sample. Indexing metagenomic samples on the viral community will provide a way categorize metagenomic samples in NCBI SRA that will allow for the identification of related sample types.

## Detecting Host and Phage Signatures

The Host Phage Interaction (HPI) group developed three tracks and databases to explore the nature of host-phage interactions, specifically:

 - Known Host-Virus Interactions Database, detailing the current known linkages of infection, collected from NCBI
 - CRISPR Spacer Database, constructed by extracting spacer information from CRISPR arrays representing a large breadth of microorganisms 
 - E. coli Prophage Virulence Factor Database, a collection of clinical and environmental E. coli screened for prophage sequences and corresponding bacterial virulence factors

![alt text](https://github.com/NCBI-Codeathons/Host_Phage_Interactions/blob/development/images/Flow.jpg)

## Known Host-Virus Interactions Database

Exisiting databases providing information on hosts (including Bacteria, Archaea, and Eukarya) and the identity of confirmed viral agents were gathered from [PhagesDB](https://phagesdb.org/) and NCBI VirusHostDB/NCBI Virus-Host Database (CITE) were combined and standardized.

The comprehensive database table consists of X virus-host pairs and a corresponding FASTA file containing the viral sequences.

## CRISPR Spacer Database

CRISPR-Cas adaptive immune systems are a unique form of adaptive immunity found in prokaryotes wherein viral DNA or RNA sequences are stored on the host genome in the form of short (~30bp) "spacers". These spacers, stored at a repetitive CRISPR "array" can be used to reliably associate viruses with their hosts.


CRISPR spacers were compiled from four distinct sources: 
 - (1) the [CRISPRCasdb](https://crisprcas.i2bc.paris-saclay.fr/Home/Download), built using [CRISPRCasFinder](https://academic.oup.com/nar/article/46/W1/W246/5001162) completely assembled genomes from RefSeq
 - (2) [a set of spacers](https://www.liebertpub.com/doi/full/10.1089/crispr.2018.0034) built using [CRISPRDetect](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4869251/) on all prokaryotic assemblies in NCBI's RefSeq (December, 2017) 
 - (3) a set of spacers found in [24345 high-quality metagenome assembled genomes](https://www.nature.com/articles/s41586-019-1058-x) (MAGs) from the human microbiome using [MinCED](https://github.com/ctSkennerton/minced) (based on [CRT](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-8-209)) 
 - (4) a set of spacers from the 24706 species-representative sequences in [GTDB](https://www.biorxiv.org/content/10.1101/771964v1) found using MinCED. 

 All genomes/MAGs were provided a standardized taxonomy based on the [GTDB taxonomy](https://gtdb.ecogenomic.org/). 

 In total this resulted in 1M unique spacer sequences (2.6M non-redundant spacer sequences) linked to a formalized source taxonomy.

## E. coli Prophage Virulence Factor Database  

Members of the "E. coli and Shigella" tax group were selected from the [NCBI Pathogen Database via the Isolates Browser](https://www.ncbi.nlm.nih.gov/pathogens/isolates/#/search/taxgroup_name:%22E.coli%20and%20Shigella%22). A subset of 10,000 genomes were identified based on the filters "Host:Human" or "Host:Homo sapiens", "Isolation type:clinical" or "Isolation type:environmental/other", and "Scientific Name:Escherichia coli". Separated into two groups, "environmental" and "clinical", genomes were sorted by GenBank Assembly ID and 3,500 genomes were downloaded for each group. [VirSorter v1.0.5](https://github.com/simroux/VirSorter) was applied to all E. coli genomes to detect prophage integrated into the genome with the parameters `--db 2`. Detected prophages were annotated using [Prokka v1.14.0](https://github.com/tseemann/prokka) with the an additional database created from the [PARTIC database v3.5.43](https://www.patricbrc.org/) to target bacterial virulence factors, including ARDB, CARD, NDARO, PATRIC_VF, TCDB, VFDB, and Victors.

![alt_text](https://github.com/NCBI-Codeathons/Host_Phage_Interactions/blob/development/images/ProphagePipeline.jpg)


# Results

## Target Discovery

![alt_text](https://github.com/NCBI-Codeathons/Host_Phage_Interactions/blob/development/images/HPI-CRISPR-DB-Workflow2.png)



## Software Workflow Diagram




# File structure diagram 
#### _Define paths, variable names, etc_

# Installation options:

### Installing <this software> from Github

1. `git clone https://github.com/NCBI-Hackathons/<this software>.git`
2. Edit the configuration files as below
3. Install packages via conda

### Configuration

```Examples here```

### Website
