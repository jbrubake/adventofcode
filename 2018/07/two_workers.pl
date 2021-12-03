#!/usr/bin/perl

use List::Util qw(max min);
use Data::Dumper;

our %times = ( 'A' => 1, 'B' => 2, 'C' => 3, 'D' => 4, 'E' => 5, 'F' => 6, 'G' => 7, 'H' => 8, 'I' => 9, 'J' => 10, 'K' => 11, 'L' => 12, 'M' => 13, 'N' => 14, 'O' => 15, 'P' => 16, 'Q' => 17, 'R' => 18, 'S' => 19, 'T' => 20, 'U' => 21, 'V' => 22, 'W' => 23, 'X' => 24, 'Y' => 25, 'Z' => 26);

while (<>) {
    chomp;
    $_ =~ /Step (.) must be finished before step (.) can begin./;

    $reqs{$1} = () if not exists $reqs{$1};
    $reqs{$2} = () if not exists $reqs{$2};
    push @{$reqs{$2}}, $1;
} 

my %done;
my @q;
while (keys %reqs) {
    my @try;
    for my $k (keys %reqs) {
        my $all_done = 1;
        next if exists $done{$k};
        for my $e (@{$reqs{$k}}) {
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
    for my $e (@do){
        $done{$e} = 1;
        delete $reqs{$e};
    }
    push @q, [@do];
}

my $worker_a_time;
my $worker_b_time;
my $time;
for my $steps (@q) {
    my $s;
    my $only_one = 0;

    if (scalar @$steps == 1) {
        $only_one = 1;
        $worker_b_time += $worker_a_time + $times{$$steps[0]} - $worker_b_time;
    }

    while ($s = shift @$steps) {
        if ($only_one || $worker_a_time <= $worker_b_time){
            $worker_a_time += $times{$s};
            print "Worker A does $s\n";
        } else {
            $worker_b_time += $times{$s};
            print "Worker B does $s\n";
        }
    }
    print "Time: $worker_a_time\n";
}

print max($worker_a_time, $worker_b_time);
