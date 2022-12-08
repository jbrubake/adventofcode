#!/usr/bin/perl
#

use strict;
use warnings;

use Graph::Directed;

my $graph = Graph::Directed->new; # create graph

while (<>) {
    # Get both node names
    chomp;
    s/Step (.) must be finished before step (.) can begin./$1$2/;
    my ($first, $second) = split //;

    $graph->add_vertex($first);
    $graph->add_vertex($second);
    $graph->add_edge($first, $second);
}

# my @nodes = split ',', $graph->stringify;
# my $root;
# for my $n (@nodes){
    # my ($f, $s) = split '-', $n;
    # if ($graph->stringify !~ /-$f/){
        # print "$f\n";
        # $root = $f;
        # last;
    # }
# }

