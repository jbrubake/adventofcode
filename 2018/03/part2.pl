#!/usr/bin/perl
#
$MAXSIZE=2000;

while (<>) {
    push @claims, $_;
}

for (my $x = 0; $x < $MAXSIZE; $x++) {
    for (my $y = 0; $y < $MAXSIZE; $y++) {
       $cloth[$x][$y] = '.';
    }
}

foreach (@claims) {
    @ret = parse ($_);

    my $id = $ret[0];
    my $lo = $ret[1];
    my $to = $ret[2];
    my $wi = $ret[3];
    my $he = $ret[4];

    # print $_;
    # print "ID:$id\t";
    # print "lo:$lo\t";
    # print "to:$to\t";
    # print "wi:$wi\t";
    # print "he:$he\n";

    $intact[$id] = 1;

    for (my $y = $to; $y < $to+$he; $y++) {
        for (my $x = $lo; $x < $lo+$wi; $x++) {
            if ($cloth[$x][$y] eq '.') {
                $cloth[$x][$y] = $id;
            } else {
                $intact[$cloth[$x][$y]] = 0;
                $intact[$id] = 0;
                $cloth[$x][$y] = 'X' ;
            }
        }
    }
}

for (my $i = 0; $i <= $#intact; $i++) {
    if ($intact[$i] == 1) {
        print "$i\n";
    }
}

sub parse () {
    $_[0] =~ /#(\d+)\s*@\s*(\d+)+,\s*(\d+)\s*:\s*(\d+)x(\d+)/;
    return $1, $2, $3, $4, $5;
}
