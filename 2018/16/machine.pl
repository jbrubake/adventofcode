#!/usr/bin/perl

use strict;
use warnings;
use v5.10.1;

our @REG = (0, 0, 0, 0);
our @OPS = (
    \&eqir,
    \&borr,
    \&addr,
    \&gtri,
    \&muli,
    \&gtir,
    \&mulr,
    \&banr,
    \&bori,
    \&eqri,
    \&eqrr,
    \&bani,
    \&setr,
    \&gtrr,
    \&addi, 
    \&seti
);

my ($op, $a, $b, $c);
while (<>) {
    chomp;
    ($op, $a, $b, $c) = split ' ', $_;
    &{$OPS[$op]} ($a, $b, $c);
}

say join ' ', @REG;

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
