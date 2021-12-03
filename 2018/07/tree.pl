#!/usr/bin/perl

use strict;
use warnings;

use Tree;
use Data::Dumper;
my $tree;
my %nodes;

while (<>) {
    # Get both node names
    chomp;
    s/Step (.) must be finished before step (.) can begin./$1$2/;
    my ($first, $second) = split //;

    # Create root node if needed
    if (!$tree) {
        $tree = Tree->new( $first ); # create tree
        $tree->set_value($first); # set value equal to node name
        $nodes{$first} = $tree; # save 'first' node
    }

    my $child = Tree->new($second); # Create child node
    $child->set_value($second); # set value equal to node name
    $nodes{$second} = $child; # save 'second' node

    $nodes{$first}->add_child($child); # Add child node
}

print map("$_\n", @{$tree -> tree2string({no_attributes => 1})});

traverse($tree);

sub traverse {
    $tree = shift;

    if ($tree->is_leaf()) {
        return;
    } else {
        for my $n ($tree->children()){
            print $tree->value . "\n";
            print $tree->parent . "\n";
            traverse($n);
        }
    }
}

