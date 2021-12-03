#!/usr/bin/perl

use strict;
use warnings;
use v5.10;
use feature qw(switch);

our @RAILS;
our @KARTS;
our $ROWS = 0;

while (<>) {
    chomp;
    $_ = find_karts ($_, $ROWS);
    my @row = split //, $_;
    $RAILS[$ROWS++] = \@row;
}

for (;;) {
    # my @rails_bak = map { [@$_] } @RAILS;
    # for (@KARTS) {
        # $rails_bak[$_->{y}]->[$_->{x}] = $_->{dir};
    # }
    # for (@rails_bak) {
        # say @$_;
    # }
    # sleep 1;

    # Sort carts
    @KARTS = sort { $a->{y} <=> $b->{y} or
                    $a->{x} <=> $b->{x} } @KARTS;

    # Loop over carts
    for my $kart (@KARTS) {
        # Move cart
        $kart = move_kart ($kart);

        # Check for collision
        if ($kart->{dir} eq 'X') {
            say "COLLISION AT $kart->{x}, $kart->{y}";
            # Delete karts
            my ($x, $y) = ($kart->{x}, $kart->{y});
            for my $i (reverse 0..$#KARTS) {
                if ($KARTS[$i]->{x} == $x and $KARTS[$i]->{y} == $y) {
                    splice (@KARTS, $i, 1);
                }
            }
        }
    }

    # If only one kart remains, print its coordinates and exit
    if (@KARTS == 1) {
        say "Final kart is located at: $KARTS[0]->{x}, $KARTS[0]->{y}";
    
    # FIXME: Last kart doesn't get to move, so I had to calculate final move
    # FIXME: manually
    say "$RAILS[$KARTS[0]->{y}]->[$KARTS[0]->{x}]";
    say "$KARTS[0]->{dir}";
        exit;
    }
}

sub move_kart {
    my $kart = shift;

    # Deal with intersections and corners
    for ($RAILS[$kart->{y}]->[$kart->{x}]) {
        when ('+') {
            for ($kart->{turn}) {
                when ('<') { $kart = turn_kart_left  ($kart); $kart->{turn} = '-'; };
                when ('-') {                                  $kart->{turn} = '>'; };
                when ('>') { $kart = turn_kart_right ($kart); $kart->{turn} = '<'; };
            }
        };
        when ('/') {
            for ($kart->{dir}) {
                when ('v') { $kart->{dir} = '<' };
                when ('^') { $kart->{dir} = '>' };
                when ('<') { $kart->{dir} = 'v' };
                when ('>') { $kart->{dir} = '^' };
            }
        };
        when ('\\') {
            for ($kart->{dir}) {
                when ('v') { $kart->{dir} = '>' };
                when ('^') { $kart->{dir} = '<'  };
                when ('<') { $kart->{dir} = '^' };
                when ('>') { $kart->{dir} = 'v' };
            }
        };
    }


    for ($kart->{dir}) {
        when ('v') { move_kart_down  ($kart); };
        when ('^') { move_kart_up    ($kart); };
        when ('<') { move_kart_left  ($kart); };
        when ('>') { move_kart_right ($kart); };
        default    { die "INVALID DIRECTION: $_"; };
    }

    $kart = check_collisions ($kart);
    return $kart;
}

sub move_kart_down {
    my $kart = shift;

    my ($x, $y) = ($kart->{x}, $kart->{y});

    for ($RAILS[$y]->[$x]) {
        when ('|')  { $kart->{y} += 1; };
        when ('+')  { $kart->{y} += 1; };
        when ('/')  { $kart->{y} += 1; };
        when ('\\') { $kart->{y} += 1; };
        default     { die "INVALID RAILWAY SECTION: $_ (tried to move down)"; };
    }

    return $kart;
}

sub move_kart_up {
    my $kart = shift;

    my ($x, $y) = ($kart->{x}, $kart->{y});

    for ($RAILS[$y]->[$x]) {
        when ('|')  { $kart->{y} += -1; };
        when ('+')  { $kart->{y} += -1; };
        when ('/')  { $kart->{y} += -1; };
        when ('\\') { $kart->{y} += -1; };
        default     { die "INVALID RAILWAY SECTION: $_ (tried to move down)"; };
    }

    return $kart;
}

sub move_kart_left {
    my $kart = shift;

    my ($x, $y) = ($kart->{x}, $kart->{y});

    for ($RAILS[$y]->[$x]) {
        when ('-')  { $kart->{x} += -1; };
        when ('+')  { $kart->{x} += -1; };
        when ('/')  { $kart->{x} += -1; };
        when ('\\') { $kart->{x} += -1; };
        default     { die "INVALID RAILWAY SECTION: $_ (tried to move down)"; };
    }

    return $kart;
}

sub move_kart_right {
    my $kart = shift;

    my ($x, $y) = ($kart->{x}, $kart->{y});

    for ($RAILS[$y]->[$x]) {
        when ('-')  { $kart->{x} += 1; };
        when ('+')  { $kart->{x} += 1; };
        when ('/')  { $kart->{x} += 1; };
        when ('\\') { $kart->{x} += 1; };
        default     { die "INVALID RAILWAY SECTION: $_ (tried to move right)"; };
    }

    return $kart;
}

sub turn_kart_left {
    my $kart = shift;

    for ($kart->{dir}) {
        when ('v') { $kart->{dir} = '>'; };
        when ('^') { $kart->{dir} = '<'; };
        when ('<') { $kart->{dir} = 'v'; };
        when ('>') { $kart->{dir} = '^'; };
        default    { die "INVALID DIRECTION: $_"; };
    }

    return $kart;
}

sub turn_kart_right {
    my $kart = shift;

    for ($kart->{dir}) {
        when ('v') { $kart->{dir} = '<'; };
        when ('^') { $kart->{dir} = '>'; };
        when ('<') { $kart->{dir} = '^'; };
        when ('>') { $kart->{dir} = 'v'; };
        default    { die "INVALID DIRECTION: $_"; };
    }

    return $kart;
}

sub check_collisions {
    my ($x, $y, $id) = ($_[0]->{x}, $_[0]->{y}, $_[0]->{id});

    for (@KARTS) {
        next if ($_->{id} == $id); 
        if ($x == $_->{x} and $y == $_->{y}) {
            $_[0]->{dir} = 'X';
        }
    }

    return $_[0];
}

sub find_karts {
    my $line = shift;
    my $row = shift;
    state $id = 0;

CHAR:
    for (my $i = 0; $i < length $line; $i++) {
        my ($dir, $r);
        for (substr $line, $i, 1) {
            when ('v') { $dir = 'v'; $r = '|'; }
            when ('^') { $dir = '^'; $r = '|'; }
            when ('<') { $dir = '<'; $r = '-'; }
            when ('>') { $dir = '>'; $r = '-'; }
            default { next CHAR; };
        }
        substr $line, $i, 1, $r;
        push @KARTS, {
            dir => $dir,
            turn => '<',
            x => $i,
            y => $row,
            id => $id++
        };
    }

    return $line;
}

