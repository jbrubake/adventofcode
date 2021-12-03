#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

our @REG_NAME = ('A', 'B', 'C', 'D', 'E', 'F');

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

our $IR = <>;
chomp $IR;
$IR =~ s/#ip //;
$REG_NAME[$IR] = 'I';

my $i = 0;
while (<>) {
    chomp;
    my ($op, $a, $b, $c) = split ' ', $_;
    say "$i\t", $OPS{$op} ($a, $b, $c);
    $i++;
}

sub addr {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $REG_NAME[$a] + $REG_NAME[$b]";
}

sub addi {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $REG_NAME[$a] + $b";
}

sub mulr {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $REG_NAME[$a] * $REG_NAME[$b]";
}

sub muli {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $REG_NAME[$a] * $b";
}

sub banr {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $REG_NAME[$a] & $REG_NAME[$b]";
}

sub bani {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $REG_NAME[$a] & $b";
}

sub borr {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $REG_NAME[$a] | $REG_NAME[$b]";
}

sub bori {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $REG_NAME[$a] | $b";
}

sub setr {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $REG_NAME[$a]";
}

sub seti {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $a";
}

sub gtir {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $a > $REG_NAME[$b] ? 1 : 0";
}

sub gtri {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $REG_NAME[$a] > $b ? 1 : 0";
}

sub gtrr {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $REG_NAME[$a] > $REG_NAME[$b] ? 1 : 0";
}

sub eqir {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $a == $REG_NAME[$b] ? 1 : 0";
}

sub eqri {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $REG_NAME[$a] == $b ? 1 : 0";
}

sub eqrr {
    my $a = shift;
    my $b = shift;
    my $c = shift;

    return "$REG_NAME[$c] = $REG_NAME[$a] == $REG_NAME[$b] ? 1 : 0";
}
