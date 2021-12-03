#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

our $IP  = 0;
our @REG = (0, 0, 0, 0, 0, 0);
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

our @PROG;
while (<>) {
    chomp;
    push @PROG, $_;
}

exec_prog ();
say "Register A: $REG[0]";

sub exec_prog {
    for ($IP = 0; $IP <= $#PROG and $IP >= 0; $IP++) {
        $REG[$IR] = $IP;
        print "$IP:\t";
        my ($op, $a, $b, $c) = split ' ', $PROG[$IP];
        print "$op ($a, $b, $c)\t";
        $OPS{$op} ($a, $b, $c);
        print "IP = ", $REG[$IR]+1, "\t";
        $IP = $REG[$IR];
        say "[A = $REG[0], B = $REG[1], C = $REG[2], D = $REG[3], E = $REG[4], F = $REG[5]]";
    }
}

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
