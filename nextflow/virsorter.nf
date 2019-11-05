#!/usr/bin/env nextflow

params.input = '~/ecoli_genomes/*.fna'
params.virsorter_out = 'virsorter_out'

genomes = Channel.fromPath(params.input)

process virsorterdb {

    output:
    file 'virsorter-data' into virsorterdata_ch

    """
    wget https://zenodo.org/record/1168727/files/virsorter-data-v2.tar.gz
    tar -xvzf virsorter-data-v2.tar.gz
    """
}

cross_ch = virsorterdata_ch.spread(genomes)

process virsorter {
    echo true
    publishDir params.virsorter_out
    
    input:
    set file(db), file(genome) from cross_ch

    output:
    file '*_output' into virsorter_out

    """
    wrapper_phage_contigs_sorter_iPlant.pl \
      -f $genome \
      --db 2 \
      --wdir ${genome.simpleName}_output \
      --data-dir $db
    """
}
