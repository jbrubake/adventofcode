#!/usr/bin/perl

use strict;
use warnings;
use v5.10.1;
use Data::Dumper;
our @REG = (0, 0, 0, 0);
our %OPS = (
    addr => \&addr,
    addi => \&addi, 
    mulr => \&mulr,
    muli => \&muli,
    banr => \&banr,
    bani => \&bani,
    borr => \&borr,
    bori => \&bori,
    setr => \&setr,
    seti => \&seti,
    gtir => \&gtir,
    gtri => \&gtri,
    gtrr => \&gtrr,
    eqir => \&eqir,
    eqri => \&eqri,
    eqrr => \&eqrr
);

our @OPCODES = ();
for (my $i = 0; $i < keys %OPS; $i++) {
    for my $instr (keys %OPS) {
        ${$OPCODES[$i]}{$instr} = 1;
    }
}

my $answer = 0;
my ($op, $a, $b, $c);
while (<>) {
    chomp;
    my @after_reg;
    my @before_reg;
    next if ($_ eq '\n');
    if (/Before/) {
        s/Before: \[(.*)\]/$1/;
        @REG = split ', ', $_;
    } elsif (/After/) {
        s/After:  \[(.*)\]/$1/;
        @after_reg = split ', ', $_;
        @before_reg = @REG;
        my $count = 0;
        my %poss;
        for (keys %OPS) {
            @REG = @before_reg;
            $OPS{$_} ($a, $b, $c);
            if (@REG ~~ @after_reg) {
                $poss{$_} = 1;
            }
        }
        for (keys %{$OPCODES[$op]}) {
            if (!exists $poss{$_}) {
                delete ${$OPCODES[$op]}{$_};
            }
        }

    } else {
        ($op, $a, $b, $c) = split ' ', $_;
    }
}
print Dumper \@OPCODES;



sub addr {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $REG[$a] + $REG[$b];
}

sub addi {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $REG[$a] + $b;
}

sub mulr {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $REG[$a] * $REG[$b];
}

sub muli {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $REG[$a] * $b;
}

sub banr {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $REG[$a] & $REG[$b];
}

sub bani {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $REG[$a] & $b;
}

sub borr {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $REG[$a] | $REG[$b];
}

sub bori {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $REG[$a] | $b;
}

sub setr {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $REG[$a];
}

sub seti {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $a;
}

sub gtir {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $a > $REG[$b] ? 1 : 0;
}

sub gtri {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $REG[$a] > $b ? 1 : 0;
}

sub gtrr {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $REG[$a] > $REG[$b] ? 1 : 0;
}

sub eqir {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $a == $REG[$b] ? 1 : 0;
}

sub eqri {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $REG[$a] == $b ? 1 : 0;
}

sub eqrr {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    $REG[$c] = $REG[$a] == $REG[$b] ? 1 : 0;
}
