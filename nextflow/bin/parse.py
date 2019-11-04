#!/usr/bin/env python

import sys


def parse_line(line, delim=','):
    return line.rstrip().split(',')


def parse_identifier(identifier):
    '''>gi|15282445|ref|NC_000918.1|_CRISPR_1_spacer_1'''
    data = identifier.split('|')
    contig_id = data[3]
    spacer_info = data[4].lstrip('_CRISPR_').split('_')
    array_number = spacer_info[0]
    spacer_position = spacer_info[2]
    return contig_id, array_number, spacer_position


def parse_fn(fn, extension='.fna'):
    return fn.rstrip(extension)


if __name__ == '__main__':
    fn = sys.argv[1]
    assembly_id = parse_fn(fn)

    with open(fn, 'r') as fh:
        lines = fh.readlines()

    info = []
    for line in lines:
        identifier, spacer = parse_line(line)
        contig_id, array_number, spacer_position = parse_identifier(identifier)
        info.append(','.join([assembly_id, contig_id, fn, spacer, array_number,
                              spacer_position]))

    with open('tmp.parse.csv', 'w') as fh_out:
        fh_out.writelines(info)

