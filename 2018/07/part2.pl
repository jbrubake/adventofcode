#!/usr/bin/perl

use v5.10;
use strict;
use warnings;

my %reqs;
while (<>) {
    chomp;
    $_ =~ /Step (.) must be finished before step (.) can begin./;

    $reqs{$1} = () if not exists $reqs{$1};
    $reqs{$2} = () if not exists $reqs{$2};
    push @{$reqs{$2}}, $1;
} 

our %times = ( 'A' => 1, 'B' => 2, 'C' => 3, 'D' => 4, 'E' => 5, 'F' => 6, 'G' => 7, 'H' => 8, 'I' => 9, 'J' => 10, 'K' => 11, 'L' => 12, 'M' => 13, 'N' => 14, 'O' => 15, 'P' => 16, 'Q' => 17, 'R' => 18, 'S' => 19, 'T' => 20, 'U' => 21, 'V' => 22, 'W' => 23, 'X' => 24, 'Y' => 25, 'Z' => 26);

my %done;
my @workers = ('.', '.', '.', '.', '.');
my @worktimes = (0, 0, 0, 0, 0);
my $total_time;

# Loop while there are still tasks to do
while (keys %reqs) {
    # Loop thru each worker
    for my $worker (0..$#workers) {
        my @do; 
        # Reduce work time if executing a task
        $worktimes[$worker]-- if ($workers[$worker] ne '.');
        # If task is complete...
        if ($worktimes[$worker] <= 0) {
            # Mark task as done, delete it and reset worker
            $done{$workers[$worker]} = 1;    
            delete $reqs{$workers[$worker]};
            $workers[$worker] = '.';

            # Get list of available tasks
            my @try;
            # Loop thru each task
            for my $k (keys %reqs) {
                my $all_done = 1;
                # Loop thru each prereq
                for my $e (@{$reqs{$k}}) {
                    # Break if one of the prereqs is not done
                    if (not exists $done{$e}) {
                        $all_done = 0;
                        last;
                    }
                }
                # Push task onto list if all prereqs complete
                if ($all_done) {
                    push @try, $k;
                }
            }
            # Sort available tasks alphabetically
            my @available = sort @try;

            # Keep only tasks not currently assigned
            for my $t (@available){
                if (!grep /$t/, @workers) {
                    push @do, $t;
                }
            }
        }
        # Assign first task to current worker and set work time
        # if there is a task to assign
        if ($do[0]) {
            $workers[$worker]   = $do[0];
            $worktimes[$worker] = $times{$do[0]}+60;
        }
    }

    # Increase total time
    $total_time++;
}

say $total_time-1;
