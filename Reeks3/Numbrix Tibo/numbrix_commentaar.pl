# Initialisatiefase

@ORGV = @ARGV;
@buren = ( [-1, 0] , [+1, 0] , [0, -1] , [0, +1] );		# dy, dx: B O L R

$X = 0;
$Y = 0;
# inlezen svg file + info uithalen
while(<>) {
	if( /<text x="(\d+)" y="(\d+)">(\d+)<\/text>/ ) {			# reeds ingevulde waardes uit svg file halen
		$x = ($1 - 25)/50;
		$y = ($2 - 35)/50;
		$result[$y][$x] = $3;			# de getallen die zeker zijn van hun vakje worden opgeslagen in de 2D-array result
		push @start, $3; 				# nodig om bij finalisatie niet een bestaand cijfer nog eens toe te voegen
	}
	elsif ( /<line x1="(\d+)" y1="(\d+)" x2="(\d+)" y2="(\d+)" \/>/ ) {		# dimensies bepalen
		$x = ($3/50) - 1;	
		$y = ($4/50) - 1;
		$X = $x > $X ? $x : $X;			# dimensie via vakjes/lijnen in svg, grootste waarde 
		$Y = $y > $Y ? $y : $Y;
	}
}


# for $y (1..$Y) {
# 	for $x (1..$X) {
# 			printf "%3d", $result[$y][$x];
# 	}
# 	print "\n";
# }

$XY = $X*$Y;			# waarde hoogste getal; getallen uit interval [1, $XY]


%todo = map {($_, undef)} 1..$XY;		# alle benodigde getallen

for $y (1..$Y) {
	for $x (1..$X) {
		delete $todo{ $result[$y][$x] }	if $result[$y][$x];  # de reeds a priori geplaatste getallen zijn niet meer 'todo' dus deze worden verwijderd
	}
}


print "\nLocatie nog niet bepaald voor: \n";
print sort {$a <=> $b} map { "$_  " } keys %todo;		# de overblijvend getallen waar nog geen plaats aan werd toegewezen


@todo = map { ($_, undef) } keys %todo;		# de hash todo ook als array definiëren, makkelijker bij initialisatie

for $y (1..$Y) {							# mu: kandidaatverzameling voor elke cel
	for $x (1..$X) {
		if ( $result[$y][$x] ) {							# als er al een waarde staat op dit veldje
			$mu[$y][$x] = { $result[$y][$x], undef } ;		# die waarde in hash toevoegen => singleton: oplossing
		}
		else {												# als de waarde van dit veldje nog bepaald moet worden
			$mu[$y][$x] = { @todo } ;						# alle nog resterende (@todo) waardes toevoegen als mogelijkheid
		}
	}
}

# print "\n";
# print join " ", %{$mu[3][1]};

# print startrooster
print "\n\n\nStartrooster: \n\n";
for $y (1..$Y) {
	for $x (1..$X) {
		if ($result[$y][$x]) {
			printf "%03d ", $result[$y][$x];		# getal met leading 0 en breedte 3, excl. spatie
		}
		else {
			print "... ";							# nog geen getal dus 3 puntjes en een spatie
		}
	}
	print "\n";
	@{$reeds[$Y]} = @{$result[$Y]};
}

print "\n\n";


$yield1 = 0;	#                        / 1 \
$yield2 = "";	# bijhouden of criterium   2    nog nuttige opbrengst heeft
$yield3 = "";	#                        \ 3 /

$yield = 1;		# opbrengst laatst toegepast criterium: verdergaan/beëindigen van iteratie


print "rij.kolom: kandidatenverzameling voor alle reducties:\n";
print_kandidatenverzameling();

# Iteratiefase

while ($yield) {
	$yield = 0;

	# REDUCTIECRITERIUM 1
	# 	een getal n (uit kandidatenverzameling van een specifieke cel) moet in 
	#	minstens 1 vd 4 buurcellen (B O L R) een getal kleiner (n-1) of groter (n+1)
	#	in zijn kandidaatverzameling mu hebben. Is dit niet het geval dan moet n
	#	verwijderd worden uit de kandidatenverzameling van die specifieke cel

	for $y (1..$Y) {
		for $x (1..$X) {
			for $w ( keys %{ $mu[$y][$x] } ) {			# elk getal die nog mogelijk is in die cel (die dus in kandidaatverzamling zit)
				$w1 = ( $w != 1 ? $w-1 : 2 );			# 0 is geen waarde dus doen we bij getal 1 nog eens een test op eentje hoger (2) ipv eentje lager
				$w2 = ( $w != $XY ? $w+1 : $XY-1 );		# indien we al aan de max waarde zitten, doen we nog eens het voorlaatste getal, eentje minder (zoals bij $w1 al het geval is) ipv eentje hoger

				$n1 = 0; 					# teller: hoeveel van de buren voldoen aan voorwaarde 1 (slagen dus voor $w1)
				$n2 = 0;					# idem, voorwaarde 2, $w2

				for (@buren) {		# Voor elke buurcel deze lus eens overlopen: Boven Onder Links Rechts

					# $dy = @{$_}[0];  $dx = @{$_}[1];
					( $dy , $dx ) = @{$_};		# de veranderingen qua cel voor een specifieke buur qua rij (y) of kolom (x)

					$n1 += scalar( grep { $_ == $w1 } keys %{ $mu[ $y + $dy ][ $x + $dx ] } );	# indien getal w1 (eentje lager dan getal w) ook in een buur-kandidatenverzameling zit, $n1 met eentje vermeerderen
					$n2 += scalar( grep { $_ == $w2 } keys %{ $mu[ $y + $dy ][ $x + $dx ] } );	# idem w2 (eentje hoger), $n2 verhogen

				}

				unless ( $n1 && $n2 ) {				# als 1 van beide 0 is, dus de nodige waarde (eentje meer of eentje minder) komt bij geen enkele van de buren voor, wordt die waarde verwijderd uit de eigen kandidatenverzameling 
					delete $mu[$y][$x]{$w};
					$yield++;		# sowieso moet deze grote while-lus nog niet verlaten worden want als nog maar pas iets ie verwijderd, moet sws nog eens opnieuw gekeken worden of er nog veranderingen kunnen plaatsvinden (indien de oplossing reeds gevonden werd, zal die lus maar 1 keer meer doorlopen worden met nergens nog een aanpassing)				
					$yield1++;		# indien er iets verwijderd werd, moet het eerste reductiecriterium nog eens opnieuw plaatsvinden want de criteria zijn strenger geworden
				}

				# print_kandidatenverzameling();	# print elke individuele stap/verwijdering van criterium 1, 
					#finaal verschijnt het resultaat van het in eerste instantie uitgemolken criterium 1

			}
		}
	}

	print "\nyield=$yield\n";
	next if $yield;		# mu's (kandidatenverzameling van elke cel) uitprinten indien reductiecriterium 1 een aanpassing teweegbracht en vooraleer aan criterium 2 en/of 3 te beginnen

	if ( ( $yield1 || $yield2 || $yield3 )  &&  keys %todo  ) {	# printen als 1 van de 3 criteriums in de recentste loop (1 nu net en 2/3 in vorige) nog iets hebben kunnen reduceren
		print "\nPrevious:\n";
		for $y (1..$Y) {
			for $x (1..$X) {
				unless ($result[$y][$x]) {		# tenzij die cel al een resultaat heeft;  unless(...) is gelijk aan if(! ...)
												# previous geeft voor elke het aantal elementen in de kandidatenverzameling mu bij de vorige print, is er iets veranderd (minder kandidaten) => * ; idem als vorige keer => geen *
					print "$y.$x:", (!defined($previous[$y][$x])		
							|| $previous[$y][$x] == scalar (keys %{$mu[$y][$x]} ) ? "\t  " : "\t* " )
								, (join " ", sort {$a <=> $b} keys %{$mu[$y][$x]} ), "\n"; 

					$previous[$y][$x] = scalar(keys %{$mu[$y][$x]});

				}
			}
		}

		print "\n\n";

		$yield1 = 0;
		$yield2 = "";
		$yield3 = "";
	}


	# REDUCTIECRITERIUM 2
	#	indien de mu voor een specifieke cel gereduceerd werd tot een singleton,
	# 	dus er werd een oplossing bekomen voor die cel, dan kan de waarde van die oplossing
	#	in geen enkele andere cel nog komen (elke waarde [1, $XY] kan slechts in 1 cel optreden)
	# 	dus moet die waarde uit elke kandidaatverzameling mu van de andere cellen verwijderd worden

	$yield2 = "";
	$yield = 1;
	while ($yield) {
		$yield = 0;

		for $y (1..$Y) {
			for $x (1..$X) {

				if ( keys %{ $mu[$y][$x] } == 1 ) {		# als de kandidatenverzameling gereduceerd werd tot een singleton
					($w) = keys %{ $mu[$y][$x] };		# enige waarde (dus oplossing/singleton) in $w steken
					# $w zonder haakjes => lengte van de hash (hier 1), zie if(...) ; ($w) met ronde haakjes => de waarde(s) van die hash, hier het ene getal als oplossing/result voor die cel 
					if ( exists $todo{$w} ) {			# als het getal (waarvoor net een cel werd gevonden) nog in todo staat, deze verwijderen
						delete $todo{$w};

						for $y0 (1..$Y) {
							for $x0 (1..$X) {					# in elke cel van het rooster
								if ($x0 != $x || $y0 != $y) {	# die niet de cel zelf is (waar de het getal moet staan in de oplossing)
									delete $mu[$y0][$x0]{$w};	# verwijderen van het getal uit de kandidatenverzameling (als het ergens zeker moet staan, kan het nergens anders meer voorkomen)
								}
							}
						}
						$result[$y][$x] = $w;				# uiteindelijk de gevonden waarde ook op de correcte plaats (juiste cel) toevoegen aan het resultaat
						$yield2 .= " ($y.$x=$w)" unless $reeds[$y][$x];		# De reeds geprinte waardes niet nog eens printen als nieuwe singleton (slechts 1 kandidaat meer in mu), de overige toevoegen/concateneren aan yield2
						$yield++;		# indien de if-structuur wordt binnengegaan na controle van een nieuwe singleton die nog in todo stond, wordt dus weer heel wat aangepast (eigen kandidatenverzameling levert een nieuw resultaat en andere kandidatenverzamelingen worden ook gereduceerd met die waarde), dus nog steeds niet de grote while-lus verlaten want er zijn opnieuw strengere criteria
					}

				}
			}
		}

	}

	if ($yield2) {		# indien criterium 2 een nieuwe oplossing heeft opgeleverd (nieuwe singleton), moet dit opnieuw geprint worden, zowel de nieuwe singletons als het tot nu toe opgeloste rooster
		print "\n# cel(len) met slechts 1 enkele kandidaat:$yield2\n\n";	# na toepassing van het 2e reductiecriterium die nieuwe singletons printen
		print_rooster();
		print "\n";
	}

	$yield = $yield2;	# na aanpassingen in criterium 2, nog eens criterium 1 opnieuw proberen vooraleer over te gaan naar criterium 3
	next if $yield2;	# leidt tot een efficiënter oplossingstraject



	# REDUCTIECRITERIUM 3
	#	Een bepaalde waarde n komt slechts in 1 kandidatenverzameling meer voor,
	#	er is dus geen andere cel waar die waarde nog zou kunnen geplaatst worden,
	#	Kn werd gereduceerd tot een singleton, dan is deze waarde dus ook 
	#	een oplossing in de cel waar die als enigste nog in de mu zit

	$yield3 = "";
	for $w (sort keys %todo) {		# alle getallen die nog niet geplaatst werden, bevinden zich nog in de hash %todo
		$todo{$w} = [];				# aan de hash met key het nog te plaatsen getal een value geven => anonieme array van kandidaatCELLENverzameling (inverse van mu)
		for $y ( 1 .. $Y ) {
			for $x ( 1 .. $X ) {
				if ( exists( $mu[$y][$x]{$w} ) ) {		# als getal w nog in een kandidatenverzameling van een bepaald cel zit
					push @{$todo{$w}} , [$y,$x];		# de coördinaten van die cel toevoegen aan de value (anonieme array) van de hash todo met als key waarde w
				}
			}
		}
		if ( @{$todo{$w}} == 1 ) {			# als er maar 1 cel/locatie (coördinatenkoppel van x en y) is waar waar getal w nog kan plaatsnemen (er is slechts 1 element in de anonieme array)
			($y, $x) = @{$todo{$w}[0]};		# de x en y waarden van die cel ([0] want er is maar 1 element in anonieme array)
			$result[$y][$x] = $w;			# het getal w toevoegen als resultaat
			%{$mu[$y][$x]} = ($w, undef);	# kandidaatverzameling werd herleid tot een singleton
			$reeds[$y][$x] = 1;				
			$yield3 .= " ($y.$x=$w)";		# De nieuwe oplossing (celcoördinaten + waarde) concateneren met $yield3, wordt ook gebruikt om te controleren of er een aanpassing gebeurde in criterium 3 
		}
	}

	if ($yield3) {			# als er iets werd aangepast in criterium 3
		print "\n# getal(len) slechts mogelijk in 1 enkele cel:$yield3\n\n";
		print_rooster();
	}

	$yield = $yield3;	# na éénmalige test over alle waarden terug naar criterium 1 (indien criterium 3 nog iets heeft veranderd)

}



# finalisatie:

@ARGV = @ORGV;		# bestand voor een 2e maal inlezen
undef $/;			# in slurpmode, volledige bestand in 1 keer, niet lijn per lijn
$^I = ".bak";		# dollar hoedje I, back-up (kopie) bestand maken van origineel en aanpassen in dat origineel bestand
$_ = <>;			# inlezen
/(.*?<\/g>.*)(<g .*>)(.*)(<\/g>.*)/s;	# regex om volledige (originele) bestand te behouden en op correcte plaats (tussen 2 en 3) de nieuwe lijnen te kunnen toevoegen

print "$1\n$2\n";		# originele eerste 2 delen alweer in bestand plaatsen


for $y (1..$Y) {
	for $x (1..$X) {
		if ($result[$y][$x]) {							# als er effectief een oplossing voor die cel gevonden werd
			unless (grep( /^$result[$y][$x]$/, @start ) ) {		# en tenzij het getal al in het originele bestand (gegeven) stond
				$ywaarde = $y*50 + 35;				# correcte y-waarde voor svg bestand
				$xwaarde = $x*50 + 25;				# idem x-waarde
				print "		<text x=\"$xwaarde\" y=\"$ywaarde\">$result[$y][$x]</text>\n";	# de tag voor het svg bestand op correcte plaats toevoegen met berekende x- en y-waardes en het gevonden getal/resultaat voor een specifieke cel
			}
		}
		
	}
}
print "$3 $4";		# rest van originele bestand terug op zijn plaats zetten










# methode om tussenin te testen: 
sub print_kandidatenverzameling {
	for $y (1..$Y) {
		for $x (1..$X) {
			print "$y.$x: ", (join " ", sort {$a <=> $b} keys %{$mu[$y][$x] }), "\n";
		}
	}
	print "\n";
}

# methode om rooster met (on)volledige oplossing uit te printen
sub print_rooster {
	for $y (1..$Y) {
		for $x (1..$X) {
			if ($result[$y][$x]) {
				printf "%03d ", $result[$y][$x];		
			}
			else {
				print "... ";							
			}
		}
		print "\n";
	}
}