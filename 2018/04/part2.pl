#!/usr/bin/perl
use Data::Dumper qw(Dumper);

# Split entries apart
my @entries;
while (<>) {
    my @ret = parse ($_);

    my $yr = $ret[0];
    my $mo = $ret[1];
    my $dd = $ret[2];
    my $hh = $ret[3];
    my $mm = $ret[4];
    my $log = $ret[5];

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
foreach (@sorted_entries) {
    my $yr = $_->{'yr'};
    my $mo = $_->{'mo'};
    my $dd = $_->{'dd'};
    my $hh = $_->{'hh'};
    my $mm = $_->{'mm'};
    my $log = $_->{'log'};

    # New guard on shift
    if ($log =~ /Guard #(\d+) begins shift/) {
        $guard = $1;
    }

    $dtg = "$yr$mo$dd";

    # Don't track unless during midnight hour
    next if ($hh ne "00");

    # Mark wake up/fall asleep times
    if ($log =~ /wakes up/) {
        $guard_sched{$guard}{$dtg}[$mm] = 'wake';
    }
    if ($log =~ /falls asleep/) {
        $guard_sched{$guard}{$dtg}[$mm] = 'sleep';
    }
}

my $awake = 'yes';
print "\t\t\t000000000011111111112222222222333333333344444444445555555555\n";
print "\t\t\t012345678901234567890123456789012345678901234567890123456789\n";
foreach my $guard (sort keys %guard_sched) {
    foreach my $dtg (sort keys %{ $guard_sched{$guard} }) {
        print "$dtg\t$guard\t";
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
                print "#";
            } else {
                $guard_sched{$guard}{$dtg}[$i] = 0;
                print " ";
            }
        }
        print "\n";
    }
}

# Sum guard asleep times
my %guard_awake_count;
my %min_totals;
foreach my $guard (sort keys %guard_sched) {
    foreach my $dtg (sort keys %{ $guard_sched{$guard} }) {
        for (my $i = 0; $i < 60; $i++) {
            if ($guard_sched{$guard}{$dtg}[$i] == 1) {
                $min_totals{$guard}[$i] += 1;
            }
        }
    }
}

my $high_guard;
my $max_time;
my $max_min;
for (my $i = 0; $i < 60; $i++) {
    foreach my $guard (keys %guard_sched) {
        next if (!$min_totals{$guard}[$i]);
        print "min $i guard $guard total $min_totals{$guard}[$i]\n";
        if ($min_totals{$guard}[$i] > $max_time) {
            $max_time = $min_totals{$guard}[$i];
            $max_min = $i;
            $high_guard = $guard;
        }
    }
}
print $high_guard * $max_min;
print "\n";

# Initial parser
sub parse () {
    $_[0] =~ /\[(....)\-(..)\-(..) (..):(..)\] (.*)/;
    return $1, $2, $3, $4, $5, $6
}
