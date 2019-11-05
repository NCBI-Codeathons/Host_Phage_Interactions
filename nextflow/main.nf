#!/usr/bin/env nextflow

params.input = 'Aquifex_aeolicus_VF5.fna'
params.minced_out = 'minced_out'

input_channel = Channel.fromPath(params.input)

process minced {
    echo true
    publishDir params.minced_out
    errorStrategy 'ignore'

    input:
    file fasta from input_channel

    output:
    file '*.gff' into minced_output_gff
    file '*.crisprs' into minced_output_crisprs
    file '*_spacers.fa' into minced_output_spacers_fa

    """
    echo $fasta
    minced -spacers -gffFull $fasta ${fasta.simpleName}.crisprs ${fasta.simpleName}.gff
    """
}

// minced_output_gff
//     .concat( minced_output_crisprs, minced_output_spacers_fa )
//     .map { file ->
//         def key = file.name.toString().split('_spacers\\.fa|\\.gff|\\.crisprs')[0]
//         return tuple(key, file)
//     }
//     .groupTuple(sort: true)
//     .set{ combined_ch }

process combine {
    echo true

    input:
    file(fa) from minced_output_spacers_fa

    output:
    file '*.parsed.csv' into minced_csv_out

    """
    awk 'BEGIN{RS=">";OFS=","}NR>1{print \$1,\$2}' $fa > ${fa.simpleName}.csv
    parse.py ${fa.simpleName}.csv ${fa.simpleName}.parsed.csv
    """
}

minced_csv_out
    .collectFile(name: params.minced_out + '/minced_out.csv', newLine: false)
