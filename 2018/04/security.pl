#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

# Split entries apart
my @entries;
while (<>) {
    my ($yr, $mo, $dd, $hh, $mm, $log) = parse ($_);

    # Hash separate timestamp data and log entry
    push @entries, {
        'yr' => $yr,
        'mo' => $mo,
        'dd' => $dd,
        'hh' => $hh,
        'mm' => $mm,
        'log' => $log
    };
}

# Sort entries
my @sorted_entries = sort {
    $a->{'yr'} <=> $b->{'yr'} ||
    $a->{'mo'} <=> $b->{'mo'} ||
    $a->{'dd'} <=> $b->{'dd'} ||
    $a->{'hh'} <=> $b->{'hh'} ||
    $a->{'mm'} <=> $b->{'mm'}
} @entries;

my $guard;
my %guard_sched;
foreach (@sorted_entries) {
    my $yr = $_->{'yr'};
    my $mo = $_->{'mo'};
    my $dd = $_->{'dd'};
    my $hh = $_->{'hh'};
    my $mm = $_->{'mm'};
    my $log = $_->{'log'};

    # New guard on shift
    $guard = $1 if ($log =~ /Guard #(\d+) begins shift/);

    my $dtg = "$yr$mo$dd";

    # Don't track unless during midnight hour
    next if ($hh ne "00");

    # Mark wake up/fall asleep times
    $guard_sched{$guard}{$dtg}[$mm] = 'wake' if ($log =~ /wakes up/);
    $guard_sched{$guard}{$dtg}[$mm] = 'sleep' if ($log =~ /falls asleep/);
}

my $awake = 'yes';
foreach my $guard (sort keys %guard_sched) {
    foreach my $dtg (sort keys %{ $guard_sched{$guard} }) {
        # print "$dtg\t$guard\t";
        for (my $i = 0; $i < 60; $i++) {
            # Toggle sleep/wake
            if ($guard_sched{$guard}{$dtg}[$i] eq 'wake') {
                $awake = 'yes';
            } elsif ($guard_sched{$guard}{$dtg}[$i] eq 'sleep') {
                $awake = 'no';
            }

            # Save sleep/wake markers
            if ($awake eq 'no') {
                $guard_sched{$guard}{$dtg}[$i] = 1;
                # print "#";
            } else {
                $guard_sched{$guard}{$dtg}[$i] = 0;
                # print " ";
            }
        }
        # print "\n";
    }
}

# Sum guard asleep times
my %guard_awake_count;
my %min_totals;
foreach my $guard (sort keys %guard_sched) {
    foreach my $dtg (sort keys %{ $guard_sched{$guard} }) {
        for (my $i = 0; $i < 60; $i++) {
            if ($guard_sched{$guard}{$dtg}[$i] == 1) {
                $guard_awake_count{$guard} += 1;
                $min_totals{$guard}[$i] += 1;
            }
        }
    }
}
my @guards = sort { $guard_awake_count{$a} <=> $guard_awake_count{$b} } keys %guard_awake_count;

my $result;
for (my $i = 0; $i < 60; $i++) {
    my $max;
    my $test= $min_totals{$guards[-1]}[$i];
    if ($test > $max) {
        $max= $test;
        $result = $i
    }
}

say $guards[-1] * $result;

# Initial parser
sub parse () {
    $_[0] =~ /\[(....)\-(..)\-(..) (..):(..)\] (.*)/;
    return $1, $2, $3, $4, $5, $6
}
