#!/usr/bin/perl

use v5.12;
use List::AllUtils qw( all none );

my @input = <>;

my %prereqs;

for my $req (@input) {
    $req =~ /([A-Z]) must be .+ step ([A-Z]) can/;
    $prereqs{$1} = [] if not exists $prereqs{$1};
    $prereqs{$2} = [] if not exists $prereqs{$2};
    push @{$prereqs{$2}}, $1;
}

my @steps = keys %prereqs;

# Part 1

{
    my %done;

    while (keys %done < keys %prereqs) {
        my @todo = sort { $a cmp $b } grep { not exists $done{$_} and all { exists $done{$_} } @{$prereqs{$_}} } @steps;
        print $todo[0];
        $done{$todo[0]} = 1;
    }

    say "";
}

# Part 2

sub tasktime {
    return (ord $_[0]) - (ord 'A') + 1 + 60;
}

{
    my %done;
    my @done;
    my $time = 0;
    my $nworkers = 5;

    my @workers = ('.') x $nworkers;
    my @tasktimes = (0) x $nworkers;

    my $cols_width = @workers * 2 - 1;
    printf "%5s %-${cols_width}s %s\n", "TIME", "WORKERS", "COMPLETED";

    do {
        for my $worker (0..$#workers) {
            $tasktimes[$worker] --;
            if ($tasktimes[$worker] <= 0) {
                $done{$workers[$worker]} = 1 if $workers[$worker] ne '.';
                $workers[$worker] = '.';
                my @todo = sort { $a cmp $b } grep { not exists $done{$_} and all { exists $done{$_} } @{$prereqs{$_}} } @steps;
                @todo = grep { my $task = $_; none { $_ eq $task } @workers } @todo;
                if (@todo) {
                    $workers[$worker] = $todo[0];
                    $tasktimes[$worker] = tasktime $todo[0];
                }
            }
        }
        printf "%5d %${cols_width}s %s\n", $time, (join ' ', @workers), (join '', map {lc} sort keys %done);
        $time++;
    } until (all { $_ eq '.' } @workers);

    say $time - 1;
}
