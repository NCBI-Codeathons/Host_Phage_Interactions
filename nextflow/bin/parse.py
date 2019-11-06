#!/usr/bin/env python

import sys


def parse_line(line, delim=','):
    return line.rstrip().split(',')


def parse_identifier(identifier):
    '''>NZ_LMFV01000001.1_CRISPR_1_spacer_26'''
    data = identifier.split('_CRISPR_')
    contig_id = data[0].lstrip('>')
    spacer_info = data[1].split('_')
    array_number = spacer_info[0]
    spacer_position = spacer_info[2]
    return contig_id, array_number, spacer_position


def parse_fn(fn, extension='_spacers.csv'):
    return fn.rstrip(extension)


if __name__ == '__main__':
    fn = sys.argv[1]
    output_fn = sys.argv[2]
    assembly_id = parse_fn(fn)

    with open(fn, 'r') as fh:
        lines = fh.readlines()

    info = []
    for line in lines:
        identifier, spacer = parse_line(line)
        contig_id, array_number, spacer_position = parse_identifier(identifier)
        info.append(','.join([assembly_id, contig_id, spacer, array_number,
                              spacer_position]) + '\n')

    with open(output_fn, 'w') as fh_out:
        fh_out.writelines(info)
