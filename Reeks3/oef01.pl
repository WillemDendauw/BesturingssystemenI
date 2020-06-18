#Initialiseer twee twee-dimensionale array's, respectievelijk met 2x3 en met 3x2 elementen. Interpreteer deze
#twee-dimensionale array's als matrices, voer de matrix-vermenigvuldiging uit, en schrijf het resultaat uit.

#alternatief 1:

$x = [ #anonymous array
	[ 3, 2, 3],
	[ 5, 9, 8]
	];

$y = [
	[ 4, 7 ],
	[ 9, 3 ],
	[ 8, 1 ],
	];

my $xrows = @{$x}; #aantal rijen in x
my $xcols = @{$x->[0]}; #aantal colommen in x
my $yrows = @{$y}; #aantal rijen in y
my $ycols = @{$y->[0]}; #aantal colommen in y

die "indexerror= matrices don't match: $xcols != $yrows" if $xcols != $yrows;

my $z = [];

for $i (0 .. ($xrows - 1)) {
	for $j (0 .. ($ycols - 1)) {
		for $k (0 .. ($xcols - 1)) {
			$z->[$i][$j] += $x->[$i][$k] * $y->[$k][$j];
		}
		printf "%4d",$z->[$i][$j];
	}
	print "\n";
}



#alternatief 2:

@x = (
    [ 3, 2, 3 ],
    [ 5, 9, 8 ],
    );
    
@y = (
    [ 4, 7 ],
    [ 9, 3 ],
    [ 8, 1 ],
    );

my $xrows = @x;
my $xcols = @{$x[0]};
my $yrows = @y;
my $ycols = @{$y[0]};

die "IndexError: matrices don't match: $xcols != $yrows" if $xcols != $yrows;

my @z = ();

for $i (0 .. ($xrows - 1)) {
	for $j (0 .. ($ycols - 1)) {
		for $k (0 .. ($xcols - 1)) {
			$z[$i][$j] += $x[$i][$k] * $y[$k][$j];
		}
		printf "%4d",$z[$i][$j];
	}
	print "\n";
}