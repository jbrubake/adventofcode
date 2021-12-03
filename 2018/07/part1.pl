#!/usr/bin/perl

use Data::Dumper;

while (<>) {
    chomp;
    $_ =~ /Step (.) must be finished before step (.) can begin./;

    $reqs{$1} = () if not exists $reqs{$1};
    $reqs{$2} = () if not exists $reqs{$2};
    push @{$reqs{$2}}, $1;
} 

my %done;
while (keys %reqs) {
    my @try;
    for my $k (keys %reqs) {
        my $all_done = 1;
        next if exists $done{$k};
        for $e (@{$reqs{$k}}) {
           if (not exists $done{$e}) {
               $all_done = 0;
               last;
           }
        }
        if ($all_done) {
            push @try, $k;
        }
    }

    @do = sort @try;
    $done{$do[0]} = 1;
    delete $reqs{$do[0]};
    print "$do[0]";
}

print "\n";
