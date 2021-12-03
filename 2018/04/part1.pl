#!/usr/bin/perl
use Data::Dumper qw(Dumper);

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
# print "\t\t\t000000000011111111112222222222333333333344444444445555555555\n";
# print "\t\t\t012345678901234567890123456789012345678901234567890123456789\n";
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
    # print "$guard slept for $guard_awake_count{$guard}\n";
}
my @guards = sort { $guard_awake_count{$a} <=> $guard_awake_count{$b} } keys %guard_awake_count;
# print "$guards[-1]\n";

my $max;
my $result;
for (my $i = 0; $i < 60; $i++) {
    $test= $min_totals{$guards[-1]}[$i];
    if ($test> $max) {
        $max= $test;
        $result = $i
    }
}
# print "$result\n";

print $guards[-1] * $result;
print "\n";

# Initial parser
sub parse () {
    $_[0] =~ /\[(....)\-(..)\-(..) (..):(..)\] (.*)/;
    return $1, $2, $3, $4, $5, $6
}
