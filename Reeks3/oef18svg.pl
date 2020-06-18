#initialisatie
#lees een lijn van het bestand en sla die op
# result: array waarin een array wordt geplaatst $y,$x
# todo: hash met als key alle getallen die mogelijk zijn, value niets
# todo: een array met de keys van de todo hash
# mu: een array van array van hash met de mogelijke waarden voor die cel
# het startrooster eens uitprinten
# reeds_geprint_in_rooster: doet hetzelfde als de result??
# alle yields instellen

@ORGV = @ARGV;
@buren = ([-1,0],[+1,0],[0,-1],[0,+1]);

$X=0;
$Y=0;

while(<>){
	#de reeds ingevulde waarden uit het rooster halen
	if( /<text x="(\d+)" y="(\d+)">(\d+)<\/text>/ ){
		$x = ($1 - 25)/50;
		$y = ($2 - 35)/50;
		$result[$y][$x] = $3;
		push @start, $3;
	}
	#bepalen van de maximale dimensie van het rooster
	elsif( /<line x1="(\d+)" y1="(\d+)" x2="(\d+)" y2="(\d+)" \/>/ ){
		$x = ($3/50) - 1;
		$y = ($4/50) - 1;
		$X = $x > $X ? $x : $X;
		$Y = $y > $Y ? $y : $Y;
	}
} 

$XY = $X * $Y;

#todo hash instellen
%todo = map { ($_,undef)} 1..$XY;

for $y (1..$Y){
	for $x (1..$X){
		delete $todo{ $result[$y][$x] } if $result[$y][$x]; # de al ingevulde waarden uit de todo halen
	}
}

#printen van alle mogelijke waarden
print "\nLocatie nog niet bepaald voor: \n";
print map{ "$_ " } sort { $a <=> $b } keys %todo;

#todo array instellen
@todo = map { ($_, undef ) } keys %todo;

#mu instellen voor elke lege cel
for $y (1..$Y) {
	 for $x (1..$X){
	 	if ( $result[$y][$x] ){
	 		$mu[$y][$x] = { $result[$y][$x], undef};
	 	}
	 	else {
	 		$mu[$y][$x] = {@todo};
	 	}
	 }
}

# het startrooster uitprinten

print "\n\n\nStartrooster: \n\n";
for $y (1..$Y){
	for $x (1..$X){
		if ($result[$y][$x]){
			printf "%03d ", $result[$y][$x];
		}
		else {
			print "... ";
		}
	}
	print "\n";
	@{$geprint[$y]} = @{$result[$Y]}; #????????????
}

print "\n\n";

#yields klaarzetten

$yield1 = 0;
$yield2 = "";
$yield3 = "";

$yield = 1;


while($yield) {
	$yield = 0;
	#criterium 1
	#controleren voor alle cellen of de buren een getal 1 groter of 1 kleiner hebben endien niet mag het getal weg
	#printen als er verandering geweest is in één van de vorige iteraties (gelijk welk criterium)

	for $y (1..$Y){
		for $x (1..$X){
			for $w ( keys %{ $mu[$y][$x]}) {
				$w1 = ( $w != 1 ? $w-1 : 2);
				$w2 = ( $w != $XY ? $w+1 : $XY-1);

				$n1 = 0;
				$n2 = 0;

				#alle buren overlopen
				for (@buren){
					($dy,$dx) = @{$_};

					 $n1 += scalar ( grep { $_ == $w1 } keys %{ $mu[$y+$dy][$x+$dx]} );
					 $n2 += scalar ( grep { $_ == $w2 } keys %{ $mu[$y+$dy][$x+$dx]} );
				}
				unless( $n1 && $n2 ){ 
					delete $mu[$y][$x]{$w};
					$yield++;
					$yield1++;
				}
			}
		}
	}

	print "\nyield=$yield\n";
	next if $yield; #als het iets heeft opgebracht probeer het opnieuw, tot het niets meer opbrengt

	#als je hier raakt, heeft criterium 1 niets meer opgebracht
	if(( $yield1 || $yield2 || $yield3 ) && keys %todo ) {
		print "\nPrevious:\n";
		for $y (1..$Y){
			for $x (1..$X){
				unless ($result[$x][$y]){
					print "$y.$x:", (!defined($previous[$y][$x]) || $previous[$y][$x] == scalar (keys %{$mu[$y][$x]} ) 
								? "\t  " : "\t* ") , (join " ", sort {$a <=> $b} keys %{$mu[$y][$x]} ), "\n";
					$previous[$y][$x] = scalar ( keys %{$mu[$y][$x]});
				}
			}
		}

		$yield1 = 0;
		$yield2 = "";
		$yield3 = "";
	}


	#criterium 2
	#als de mogelijke waarden voor een cel slechts 1 bedraagt dan moet je die invullen (mu[y][x] bevat slechts 1 key meer)
	#uitprinten van het ingevuld rooster

	print "\n\nStart criterium2\n\n";
	$yield2="";
	$yield = 1;
	while($yield){
		$yield = 0;

		for $y (1..$Y){
			for $x (1..$X){
				if (keys %{ $mu[$y][$x] } == 1) {
					($w) = keys %{ $mu[$y][$x] };
					if( exists $todo{$w} ) { #als het cijfer nog in de todo staat dan mmoet je hem uit de mu van alle cellen halen
						delete $todo{$w};
						for $y0 (1..$Y){
							for $x0 (1..$X){
								if($x0!=$x || $y0!=$y){
									delete $mu[$y0][$x0]{$w}
								}
							}
						}
						$result[$y][$x] = $w;
						$yield2 .= " ($y.$x=$w)" unless $geprint[$y][$x];
						$yield++;
					}
				}
			}
		}
	}

	print "test geraakt vlak voor printen van cellen met 1 enkele kandidaat\n\n";
	if($yield2){ #heeft criterium2 een nieuwe oplossing gevoncen?
		print "\n# cel(len) met slechts 1 enkele kandidaat:$yield2\n\n";
		for $y (1..$Y){
			for $x (1..$X){
				if($result[$y][$x]) {
					printf "%03d ", $result[$y][$x];
				}
				else {
					print "... ";
				}
			}
			print "\n";
		}
		print "\n";
	}

	$yield = $yield2;
	next if $yield2; #als yield2 iets heeft opgebracht, criterium 1 nog eens proberen

	#criterium 3
	#hash todo vullen met een array van cellen waar die waarde mogelijks nog in past
	#indien er voor die waarde maar 1 mogelijke cel is dan moet je hem invullen
	#print het rooster weer uitprinten

	$yield3="";
	for $w (sort keys %todo){
		$todo{$w} = [];
		for $y (1..$Y){
			for $x (1..$X){
				if (exists( $mu[$y][$x]{$w})){
					push @{$todo{$w}}, [$y,$x];
				}
			}
		}
		if (@{$todo{$w}} == 1){
			($y,$x) = @{$todo{$w}[0]};
			$result[$y][$x] = $w;
			%{$mu[$y][$x]} = ($w, undef);
			$geprint[$y][$x] = 1;
			$yield3 .= " {$y.$x=$w)";
		}
	}

	if ($yield3){
		print "\n# getallen slechts mogelijk in 2 enkele cel: $yield3\n\n";
		for $y (1..$Y){
			for $x (1..$X){
				if($result[$y][$x]) {
					printf "%03d ", $result[$y][$x];
				}
				else {
					print "... ";
				}
			}
			print "\n";
		}
		print "\n";
	}

	$yield = $yield3;
}

#finalisatie

@ARGV = @ORGV;
undef $/;
$^I = ".bak";
$_ = <>;
/(.*?<\/g>.*)(<g .*>)(.*)(<\/g>.*)/s;

print "$1\n$2\n";

for $y (1..$Y){
	for $x (1..$X){
		if ($result[$y][$x]){
			unless (grep( /^$result[$y][$x]$/, @start)){
				$ywaarde = $y*50 + 35;
				$xwaarde = $x*50 + 25;
				print "		<text x=\"$xwaarde\" y=\"$ywaarde\">$result[$y][$x]</text>\n";
			}
		}
	}
}
print "$3 $4";





#print het volledige rooster uit