#!/usr/bin/perl

use strict;
use warnings;
use v5.10;

my @license = split ' ', <>;

print "Part 1: ";
print &license_check_one (0, @license);
say "";

sub license_check_one {
    my $sum = shift;
    my $num_kids = shift;
    my $num_data = shift;

    for (1..$num_kids) {
        @_ = license_check_one ($sum, @_);
        $sum = shift;
    }

    for (1..$num_data) {
        $sum += shift;
    }

    return $sum, @_;
}

my %nodes;
license_check_two (@license);
print "Part 2: ";
print &calculate_root_value (1);
say "";

sub license_check_two {
    # Running node index
    state $index = 1;

    my $i        = $index++; # currnet node index
    my $num_kids = shift;    # number of kids
    my $num_data = shift;    # amount of metadata
    my $sum;

    # Process each kid
    for (1..$num_kids) {
        # Save index to next kid
        push @{$nodes{$i}->{'kids'}}, $index;
        @_ = license_check_two (@_);
    }

    # Get each metadata value
    for (1..$num_data) {
        my $n = shift;
        # If no kids, data is a value
        if (!$num_kids) {
            $sum += $n;
        } else {
            # Set default value
            $nodes{$i}->{'val'} = 0;
            # Push metadata
            push @{$nodes{$i}->{'data'}}, $n;
        }
    }
    if (!$num_kids) {
        $nodes{$i}->{'val'} = $sum;
    }

    return @_;
}

sub calculate_root_value {
    my $i= shift;
    my $value = 0;

    # Return value if no kids
    if (!exists $nodes{$i}->{'kids'}) { 
        return $nodes{$i}->{'val'};
    } else {
        for my $kid (@{$nodes{$i}->{'data'}}) {
            my $no_good_kids = 1;
            if ($kid <= @{$nodes{$i}->{'kids'}} ) {
                my $k = @{$nodes{$i}->{'kids'}}[$kid-1];
                $value += calculate_root_value ($k);
            }
        }
    }

    return $value;
}

