#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

use List::Util qw(min max);

my @points;
while (<>) {
    /position=<(.*),(.*)> velocity=<(.*),(.*)>/;
    push @points, {
        x => $1,
        y => $2,
        dx => $3,
        dy => $4
    }
}

my $s = 0;
while () {
    print_msg (@points);
    for my $p (@points) {
        $p = move_point ($p);
    }
    say $s;
    $s++;
}

sub move_point {
    my $p = shift;

    return {
        x => $p->{'x'} + $p->{'dx'},
        y => $p->{'y'} + $p->{'dy'},
        dx => $p->{'dx'},
        dy => $p->{'dy'}
    };
}

sub print_msg {
    my @points = @_;

    my ($min_x, $min_y, $max_x, $max_y) = get_bounds (@points);

    if ($max_x - $min_x > 100) {
        return;
    }
    sleep 1;
    system "tput clear";
    for my $p (@points) {
        my $x = ($p->{'x'} - $min_x);
        my $y = ($p->{'y'} - $min_y);
        system "tput cup $y $x";
        print "#";
    }
}

sub get_bounds {
    my @points = @_;

    my $p = shift @points;
    my ($min_x, $min_y, $max_x, $max_y) = (
        $p->{'x'},
        $p->{'y'},
        $p->{'x'},
        $p->{'y'});

    for $p (@points) {
        $min_x = min ($min_x, $p->{'x'});        
        $min_y = min ($min_y, $p->{'y'});        
        $max_x = max ($max_x, $p->{'x'});        
        $max_y = max ($max_y, $p->{'y'});        
    }

    return ($min_x, $min_y, $max_x, $max_y);
}
