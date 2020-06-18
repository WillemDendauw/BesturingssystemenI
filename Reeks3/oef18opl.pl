@buren=([-1,0],[+1,0],[0,-1],[0,+1]); # relatieve coördinaten van buurcellen
                                      # enige lijn die moet aangepast worden
                                      # indien bijvoorbeeld ook/enkel diagonale buren zouden mogen

$Y=0;                                 # aantal rijen
while (<>) {
    chomp;
    @{$result[++$Y]}=map {$_>0 ? 0+$_ : undef} split;
                                      # @result redundant: zouden anders
                                      # continu aantal keys van mu hashes moeten evalueren
    unshift @{$result[$Y]},undef;     # nuttige indexering laten beginnen vanaf 1
    $X=$#{$result[$Y]} unless $X;     # aantal kolommen
}
$XY=$X*$Y;

%todo=map {($_,undef)} 1..$XY;        # todo keys: getallen die nog niet zijn toegewezen aan cel
for $y (1..$Y) {                      #    values: enkel ingesteld bij uitvoering criterium 3
    for $x (1..$X) {
        delete $todo{$result[$y][$x]} if $result[$y][$x];
    }
}

@todo=map {($_,undef)} keys %todo;    # array versie van hash todo: efficienter bij initialisatie
for $y (1..$Y) {                      # van values mu hashes (kandidaatverzamelingen van elke cel)
    for $x (1..$X) {
        $mu[$y][$x]=($result[$y][$x] ? {$result[$y][$x],undef} : {@todo});
    }
}

for my $y (1..$Y) {
    print join " ",map {$result[$y][$_] ? sprintf "%03d",$result[$y][$_] : "..."} 1..$X;
    print "\n";
    @{$reeds_geprint_in_rooster[$Y]}=@{$result[$Y]};
                                      # om overbodige logging van criterium 2 te vermijden
                                      # bij geslaagde iteratie over criteria 2 en 3
                                      # wordt immers daar het rooster opnieuw uitgeprint
}
print "\n";

$yield1=0;                 #                        / 1 \
$yield2="";                # bijhouden of criterium   2  al dan niet nog nuttige opbrengst heeft
$yield3="";                #                        \ 3 /
$yield =1;                 # opbrengst laatst toegepast criterium continueert/beëindigt iteratie

while ($yield) {
    $yield=0;
#                    _
#                   / |
# Reductiecriterium | |
#                   |_|
#
    for my $y ( 1 .. $Y ) {
        for my $x ( 1 .. $X ) {
            for my $w ( keys %{ $mu[$y][$x] } ) {
                my $w1=($w != 1   ? $w-1 : 2);
                my $w2=($w != $XY ? $w+1 : $XY-1);
                           # voor 1 en $XY: makkelijker om twee maal dezelfde test uit te laten voeren
                my ($n1,$n2)=(0,0);
                for (@buren) {
                    my ($dy,$dx)=@{$_};
                           # hoeveel keer treedt waarde $w-1 op in de omliggende buren ?
                    $n1+=scalar(grep {$_ == $w1} keys %{ $mu[$y+$dy][$x+$dx]});
                           # hoeveel keer treedt waarde $w+1 op in de omliggende buren ?
                    $n2+=scalar(grep {$_ == $w2} keys %{ $mu[$y+$dy][$x+$dx]});
                           # veel simpelere oplossing dan met if testen te coderen !
                           # je ook realiseren dat je pijnloos de mu's aanspreekt van "buren" buiten het rooster
                           # strikte value checking zou specifieke code vereisen voor cellen aan de rand van het rooster
                }
                unless ($n1 && $n2) {
                    delete $mu[$y][$x]{$w};
                    $yield++;  # opbrengst in laatste iteratie over alle roostercellen
                    $yield1++; # cumulatieve opbrengst in opeenvolgende iteraties van louter criterium 1
                }
            }
        }
    }
    next if $yield;
                           # mu's uitprinten vooraleer opnieuw aan reductiecriteria 2 en 3 te beginnen
                           # enkel na geslaagde (iteratieve) toepassing reductiecriterium
                           # $yield1: nuttige opbrengst van criterium 1 tijdens deze iteratiestap
                           # $yield2 en $yield3: opbrengst van criteria 2 en 3 in vorige iteratiestap
    if (($yield1 || $yield2 || $yield3) && keys %todo) {
        for my $y ( 1 .. $Y ) {
            for my $x ( 1 .. $X ) {
                unless ($result[$y][$x]) {
                           # previous geeft voor elke cel het aantal elementen in de mu bij de vorige uitprint:
                           # nodig om de cel te kunnen accentueren met een * als er iets gereduceerd kon worden
                    print "$y.$x:",(!defined($previous[$y][$x])
                                          || $previous[$y][$x]==scalar(keys %{$mu[$y][$x]}) ? "\t  " : "\t* ")
                                  ,(join " ",sort {$a <=> $b} keys %{$mu[$y][$x]}),"\n";
                    $previous[$y][$x]=scalar(keys %{$mu[$y][$x]});
                }
            }
        }
        $yield1=0;
        $yield2="";
        $yield3="";
    }
#                   ___
#                  |_  )
# Reductiecriterium / /
#                  /___|
#
    $yield2="";
    $yield =1;
    while ($yield) {
        $yield=0;
        for my $y ( 1 .. $Y ) {
            for my $x ( 1 .. $X ) {
	        if (keys %{ $mu[$y][$x]}==1) {
                    my ($w)=keys %{ $mu[$y][$x]};
                    if ( exists $todo{$w}) {
                        delete $todo{$w};
                        for my $y0 ( 1 .. $Y ) {
                            for my $x0 ( 1 .. $X ) {
                                delete $mu[$y0][$x0]{$w} if ($x0!=$x || $y0!=$y);
                            }
                        }
                        $result[$y][$x]=$w;
                        $yield2.=" ($y.$x=$w)" unless $reeds_geprint_in_rooster[$y][$x];
                           # aangezien bij elke loop eerst het rooster nog eens wordt uitgeprint
                           # en de geslaagde toepassing op een cel toch maar eenmaal moet gelogd worden
                        $yield++;
                           # loopen over louter criterium 2, zonder eerst criterium 1 toe te passen
                    }
                }
            }
        }
    }

    if ($yield2) {
        print "\n# cel(len) met slechts 1 enkele kandidaat:$yield2\n\n";
          for my $y (1..$Y) {
            print join " ",map {$result[$y][$_] ? sprintf "%03d",$result[$y][$_] : "..."} 1..$X;
            print "\n";
        }
        print "\n";
    }

    $yield =$yield2;       # na criterium 2 succesvol, opnieuw 1 vooraleer aan 3 te beginnen
    next if $yield2;       # leidt tot efficiënter oplossingstraject
#                   ____
#                  |__ /
# Reductiecriterium |_ \
#                  |___/
#
    $yield3="";
    for my $w (sort keys %todo) {
        $todo{$w}=[];      # todo values: kandidaatcellenverzameling (inversie van mu)
        for my $y ( 1 .. $Y ) {
            for my $x ( 1 .. $X ) {
                push @{$todo{$w}},[$y,$x] if exists $mu[$y][$x]{$w};
            }
        }
        if (@{$todo{$w}}==1) {
            my ($y,$x)= @{$todo{$w}[0]};
            $result[$y][$x]=$w;
            %{$mu[$y][$x]}=($w,undef);
            $reeds_geprint_in_rooster[$y][$x]=1;
            $yield3.=" ($y.$x=$w)";
        }
    }

    if ($yield3) {
        print "\n# getal(len) slechts mogelijk in 1 enkele cel:$yield3\n\n";
        for my $y (1..$Y) {
            print join " ",map {$result[$y][$_] ? sprintf "%03d",$result[$y][$_] : "..."} 1..$X;
            print "\n";
        }
        print "\n";
    }

    $yield=$yield3;        # na éénmalige test over alle waarden
}                          # indien positief: volgende iteratiestap over criteria 1,2,3

for my $y (1..$Y) {        # kandidaatverzamelingen van cellen die niet gereduceerd werden
    for my $x (1..$X) {
        print "$y.$x: ",(join " ",sort {$a <=> $b} keys %{$mu[$y][$x]}),"\n" unless scalar(keys %{$mu[$y][$x]})<=1;
    }
}