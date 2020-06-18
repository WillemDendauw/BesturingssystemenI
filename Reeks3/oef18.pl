# Verwerk eerst de inleidende demonstratie (ook beschikbaar op Ufora). Open dit PowerPoint bestand in de Show Presenter View van Slide Show. Volg de aanwijzingen erin strikt, vooraleer je aan de opgave begint. Vind de unieke oplossing voor elk van de numbrix-puzzels in numbrix.zip (in de corresponderende tekstbestanden vind je intermediaire uitvoer terug).


# In deze oefening beschouwen we een vierkantig rooster.
# Het aantal cellen in elke rij en elke kolom wordt aangeduid met de letter N.
# Je kan best de rijen (van boven naar onder),
# en de kolommen (van links naar rechts),
# nummeren met een integer in het interval [1..N].

# Sommige cellen van het rooster zijn a priori ingevuld,
# met een geheel getal uit het interval [1..N²].
# Deze informatie wordt eenvoudig gecodeerd in tekstformaat,
# in een bestand met extentie .numbrix.
# De naam van dit bestand moet als enige parameter meegegeven worden
# bij het uitvoeren van jouw script.

# Het is de bedoeling om elk geheel getal uit het interval [1..N²]
# in één van de roostercellen te plaatsen,
# met als restrictie dat opeenvolgende getallen in naburige cellen terecht komen.
# Elke cel heeft maximaal 4 buren, boven, onder, links en rechts.
# Voor elk probleem van oefening 18 blijkt er maar één mogelijke oplossing te zijn.
# Om je te helpen bij de ontwikkeling en het uittesten van het script,
# is er voor elk van de problemen een txt bestand beschikbaar,
# dat de opeenvolgende iteraties en stappen van een oplossingstraject illustreert. 

# De oplossingsmethode bestaat uit een initialisatie,
# gevolgd door een iteratiefase,
# ……


# ……
# Initialisatie fase

# Lees het numbrix bestand in. 
# Het aantal cellen N, in elke rij en elke kolom,
# kan zowel worden afgeleid uit het aantal lijnen in hetnumbrix bestand,
# als uit het aantal velden op elke lijn.

# Implementeer een perl datastructuur die voor
# elke cel cr,k, met rijnummer r en kolomnummer k,
# een kandidaatverzameling, µr,k, bijhoudt.
# µr,k stelt telkens een zo beperkt mogelijke verzameling gehele getallen voor,
# waartoe uiteraard ook de uiteindelijke waarde van de cel behoort.
# Het ligt voor de hand om hiervoor in perl
# een array van array's van hashes te gebruiken,
# te indexeren via µ[een rij][een kolom]{een kandidaat},
# zonder dat de bijhorende value er iets toe doet.

# Voor a priori ingevulde cellen is de overeenkomstige µr,k
# reeds beperkt tot een singleton, één enkel getal. 

# De initialisatiefase moet ook een µr,k opstellen voor alle andere cellen.
# Pas de latere iteratiefase zal ervoor zorgen dat alle µr,k's
# uiteindelijk zullen gereduceerd worden tot singletons. 

# Hoewel niet verplicht, is het aangewezen om 
# eveneens een geïnverteerde datastructuur  te construeren,
# die voor elk getal n een kandidaatcellenverzameling, Kn, bijhoudt:
# een zo beperkt mogelijke verzameling cellen die de waarde n zouden kunnen bevatten.

# Voor waarden, die in a priori ingevulde cellen voorkomen,
# is de overeenkomstige Kn reeds beperkt tot één enkele cel.
# Pas na uitvoering van de volledige iteratiefase,
# zullen ook alle Kn‘s gereduceerd zijn tot singletons.
# Indien je opteert om Kn‘s te implementeren,
# zal repetitief opzoekingswerk in de µr,k’s vermeden kunnen worden.
# Anderzijds zal je er zelf moeten voor zorgen dat de Kn’s en de µr,k’s
# na elke reductie steeds consistent blijven. 
# Steeds weerkerende keuze waarvoor je als programmeur gesteld wordt:
# versnellen van opzoeking vs. vermijden van redundante gegevens.

# In de initialisatiefase zorg je ervoor dat:
# 1.voor elke a priori met een waarde n ingevulde cel cr,k,
# de µr,k ingesteld wordt op het singleton {n}.
# 2. voor alle andere cellen,
# de µr,k ingesteld wordt op de verzameling van alle integers uit het interval [1..N²],
# waarvan niet a priori geweten is, in welke cellen die zich bevinden.

# Het is de bedoeling dat jouw script, na elke relevante stap,
# de inhoud van de µr,k’s, en eventueel de Kn’s,
# op het standaard uitvoerkanaal kan weergeven,
# al dan niet inclusief de op singleton gereduceerde cellen,
# Hierdoor kan de correcte implementatie van die stap makkelijker getoetst worden. 

# Na de initialisatiefase moet je bijvoorbeeld bekomen:
# 1.1: 2 4 6 7 8 10 11 12 14 15 16 18 19 20 22 24 25
# 1.2: 2 4 6 7 8 10 11 12 14 15 16 18 19 20 22 24 25
# 1.4: 2 4 6 7 8 10 11 12 14 15 16 18 19 20 22 24 25
# ……
# 5.2: 2 4 6 7 8 10 11 12 14 15 16 18 19 20 22 24 25
# 5.4: 2 4 6 7 8 10 11 12 14 15 16 18 19 20 22 24 25
# 5.5: 2 4 6 7 8 10 11 12 14 15 16 18 19 20 22 24 25

# equivalent met wat op de slide getoond wordt.
# ……


# ……
# Bij de oplossing van problemen zoals deze, volgt na de initialisatie een iteratiefase.
# Bij elke iteratiestap poogt men dichter tot een oplossing te komen,
# door telkens een of meerdere criteria toe te passen.

# In het numbrix probleem kunnen bij elke iteratiestap drie reductiecriteria toegepast worden.
# Elk van de drie criteria kan tot een (partiële) reductie van één of meerdere µr,k’s leiden.

# In een specifieke iteratiestap is het aangewezen
# om elk individueel reductiecriterium te blijven pogen toepassen,
# tot het geen nuttige bijdrage meer oplevert. 

# Je mag echter ook, van zodra het tweede of het derde criterium een reductie van één µr,k oplevert,
# onmiddellijk de iteratiestap afbreken (de stippellijnpijlen op de slide),
# en terug overschakelen op toepassing van het eerste reductiecriterium,
# van de volgende iteratiestap. 

# Indien geen van de drie reductiecriteria nog een resultaat opleveren,
# moet het itereren worden gestopt.
# Voor de hier behandelde problemen zou dit enkel mogen gebeuren,
# indien alle µr,k’s herleid zijn tot singletons,
# en het probleem bijgevolg volledig opgelost is.
# ……


# ……
# Eerste reductiecriterium

# Ga voor elk element n van elke µr,k, die nog niet tot een singleton is herleid,
# na of:

# 1. (indien n>1) n-1 behoort tot de kandidaatverzameling µ van minstens één buurcel,
# 2. (indien n< N²) n+1 behoort tot de kandidaatverzameling µ van minstens één buurcel.

# Tenzij beide voorwaarden voldaan zijn,
# moet n uit deze specifieke µr,k verwijderd worden.

# Zo mag 2 maar in µ1,1 blijven staan, als 1 zou optreden in µ1,2 of µ2,1.
# Dit is niet het geval.
 
# 7 mag wel in µ1,1 blijven staan,
# aangezien 6 voorkomt in µ1,2 en µ2,1 (één van de twee vaststellingen zou voldoende zijn),
# en 8 voorkomt in µ1,2 en µ2,1 (één van de twee vaststellingen zou voldoende zijn).

# De reductie van één µr,k kan een cascade van meerdere µr,k-reducties veroorzaken,
# ook van µr,k’s waarvan alle elementen,
# net ervoor, zelfs in dezelfde iteratiestap,
# wel aan beide voorwaarden voldeden.

# Dit eerste reductiecriterium moet dus wel degelijk iteratief blijven toegepast worden,
# tot geen enkele reductie meer mogelijk is. 

# het eerste reductiecriterium toepassend,
# mag niet alleen 2 uit µ1,1 verwijderd worden, maar ook 4 6 8 10 12 14 16 18 20 22 en 24
# ……


# ……
# uit µ1,2: 2 4 6 7 8 10 11 12 14 15 19 22 24 en 25
# ……


# ……
# uit µ1,4: 2 4 6 8 10 12 14 20 en 22
# ……


# ……
# uit µ1,5: 2 4 6 8 10 12 14 16 18 20 22 en 24
# ……


# ……
# uit µ2,1: 2 4 7 8 10 11 12 14 15 16 18 19 22 24 en 25
# ……


# ……
# uit µ2,3: 2 4 6 8 10 12 en 14
# ……


# ……
# uit µ2,5: 2 4 6 7 8 10 11 15 16 18 19 20 22 en 25
# ……


# ……
# uit µ3,2: 2 8 10 12 14 16 18 22 en 24
# ……


# ……
# uit µ3,3: 2 4 6 8 10 12 14 16 18 20 22 en 24
# ……


# ……
# uit µ3,4: 2 4 6 7 8 10 11 15 16 18 19 20 22 en 25
# ……


# ……
# uit µ4,1: 2 8 10 12 14 16 18 20 22 en 24
# ……


# ……
# uit µ4,3: 4 6 7 11 12 14 15 16 18 19 20 22 24 en 25
# ……


# ……
# uit µ4,5: 2 4 6 8 10 16 18 20 22 en 24
# ……


# ……
# uit µ5,1: 2 4 6 8 10 12 14 16 18 20 22 en 24
# ……


# ……
# uit µ5,2: 2 4 6 7 11 12 14 15 16 18 19 20 22 24 en 25
# ……


# ……
# uit µ5,4: 2 4 6 12 14 16 18 20 22 en 24
# ……


# ……
# uit µ5,5: 2 4 6 7 8 10 12 14 15 16 18 19 20 22 24 en 25
# ……


# ……
# Toepassing van het eerste reductiecriterium,
# op alle cellen, één voor één,
# heeft al heel wat µr,k-reducties veroorzaakt.

# Hierdoor zijn de criteria waaraan,
# de elementen in de µr,k 's van andere cellen moeten voldoen,
# er strenger op geworden.

# Het is dan ook zinvol om nogmaals alle cellen af te lopen.

# Nu mag 7 maar in µ1,1 blijven staan, als 6 nog steeds zou optreden in µ1,2 of µ2,1.
# Dit is weliswaar het geval (in µ2,1),
# maar ook 8 moet nog steeds optreden in µ1,2 of µ2,1.
# Dat is niet meer het geval.
 
# Het eerste reductiecriterium opnieuw toepassend,
# moet nu niet alleen 7 uit µ1,1 verwijderd worden, maar ook 11 15 en 25.
# ……


# ……
# uit µ1,2: enkel 16
# ……


# ……
# uit µ1,4: 7 11 15 19 en 25
# ……


# ……
# uit µ1,5: 7 11 en 19
# en uit µ2,1: enkel 6
# ……


# ……
# uit µ2,3: 7 11 15 19 en 25
# ……


# ……
# uit µ2,5: enkel 12
# ……


# ……
# uit µ3,2: 7 11 15 19 en 25
# ……


# ……
# uit µ4,1: 7 11 15 19 en 25
# ……


# ……
# uit µ4,5: 7 11 14 15 19 en 25
# ……


# ……
# uit µ5,1: 11 15 19 en 25
# ……


# ……
# uit µ5,2: enkel 10
# ……


# ……
# uit µ5,4: 7 8 11 15 19 en 25
# ……


# ……
# Nu het eerste reductiecriterium
# op alle cellen tweemaal is toegepast,
# zijn de µr,k's nog meer gereduceerd.

# Het is dan ook zinvol om nogmaals alle cellen af te lopen.

# Nu kan 18 uit µ1,4 verwijderd worden,
# aangezien19 niet optreedt in de actuele µ1,3, µ1,5 of µ2,4.

# De poging om een vierde keer alle cellen af te lopen,
# draait echter op niets uit.
# ……


# ……
# Print, telkens het eerste reductiecriterium niets meer oplevert,
# de inhoud van de µr,k’s, op het standaard uitvoerkanaal uit,
# zodat je kan vergelijken met wat (hier op de slide getoond is of)
# in de txt bestanden staat:
# 1.1:      19
# 1.2:      18 20
# 1.4:      16 24
# 1.5:      15 25
# 2.1:      20
# 2.3:      16 18 20 22 24
# 2.5:      14 24
# 3.2:      4 6 20
# 3.3:      7 11 15 19 25
# 3.4:      12 14 24
# 4.1:      4 6
# 4.3:      2 8 10
# 4.5:      12
# 5.1:      7
# 5.2:      8
# 5.4:      10
# 5.5:      11

# Het eerste reductiecriterium op zich is volledig uitgemolken.
# Tijd voor het:

# Tweede reductiecriterium

# een waarheid als een koe, om in dezelfde beeldspraak te blijven:

# Indien een µr,k, na toepassing van het eerste reductiecriterium,
# gereduceerd wordt tot het singleton {n},
# dan moet de waarde n verwijderd worden
# uit de kandidaatverzamelingen van alle andere cellen.

# Nogal logisch: als je weet dat een n in een specifieke cel optreedt,
# kan die nergens anders meer ingevuld worden.

# Op deze slide worden de corresponderde integers,
# waarop dit reductiecriterium kan toegepast worden,
# rood gekleurd.
# ……


# ……
# nu nog de µr,k’s, waarin deze optreden, aanpassen……


# ……
# zodat duidelijk wordt dat ook dit tweede reductiecriterium,
# iteratief kan toegepast worden,
# in dit geval op de integers 2 en 18.
# ……


# ……
# nu opnieuw de µr,k’s, waarin deze optreden, aanpassen……


# ……
# tot we in de situatie belanden, 
# waar ook het tweede reductiecriterium uitgemolken lijkt.

# In de txt bestanden worden die situaties,
# na toepassing van het tweede reductiecriterium,
# inclusief iteratie, tot wanneer het niets meer oplevert,
# vermeld op de regels voorafgegaan door “cel(len) met slechts 1 enkele kandidaat”,
# met vermelding van de uitgevoerde reducties.

# # cel(len) met slechts 1 enkele kandidaat: (1.1=19) (2.1=20) (1.2=18) (4.5=12) (5.1=7) (5.2=8) (5.4=10) (4.3=2) (5.5=11)

# Checken we nu opnieuw het eerste reductiecriterium:

# Nu zou 6 in µ3,2 mogen blijven staan, als 7 nog steeds zou optreden in µ2,2, µ3,1, µ3,3 of µ4,2
# Dat is niet meer het geval.
# ……


# ……
# Zodat het tweede reductiecriterium toch opnieuw kan toegepast worden,
# in eerste instantie op de 4 in cel3,2.

# Hoog tijd op nog eens de inhoud van de µr,k’s
# op het standaard uitvoerkanaal uit te printen,
# zodat je kan vergelijken met wat (hier op de slide getoond is of)
# in de overeenkomstige txt bestanden staat:

# 1.4:      16 24
# 1.5:      15 25
# 2.3:    * 16 22 24
# 2.5:      14 24
# 3.2:    * 4
# 3.3:    * 15 25
# 3.4:    * 14 24
# 4.1:      4 6

# Accentueer, zoals hierboven met een *, de cellen,
# waarvan de µr,k gewijzigd is t.o.v. een vorige uitprint.
# ……


# ……
# Het tweede reductiecriterium kan zelfs nog eens toegepast worden,
# nu op de 6 in cel4,1. 
# ……


# ……
# Maar dat is het zowat.

# Noch het eerste, noch het tweede reductiecriterium
# levert nog iets nuttigs op.

# Tijd voor het……

# ……
# Derde reductiecriterium

# Indien na toepassing van het eerste reductiecriterium blijkt
# dat het tweede reductiecriterium geen bijkomende resultaten oplevert,
# maar dat een specifieke n nog maar in één enkele µr,k optreedt,
# met andere woorden Kn volledig werd gereduceerd tot het singleton {µr,k},
# dan moet ook deze µr,k gereduceerd worden tot het singleton {n}.

# Hier komt 22, op de slide geaccentueerd met rood,
# enkel nog voor in µ2,3.
# In de logbestanden worden toepassingen van dit reductiecriterium
# vermeld op de regels voorafgegaan door “getal(len) slechts mogelijk in 1 enkele cel”.
# ……


# ……
# Waarna het eerste reductiecriterium 15 kan elimineren uit µ3,3,
# ……


# ……
# in cascade gevolgd door de verwijdering van 14 uit µ3,4,
# ……


# ……
# waarna nu opnieuw het tweede reductiecriterium kan toegepast worden op de 25 van µ3,3,
# en de 24 van µ3,4.
# ……


# ……
# en zowel 24 als 25 uit de overige µr,k’s kunnen verwijderd worden.
# ……


# ……
# Alle µr,k’s zijn hierdoor tot singletons gereduceerd,
# ……


# ……
# en het probleem is volledig opgelost.

# Produceer analoge uitvoer als in de txt bestanden,
# zodat je jouw implementatie van de diverse criteria,
# in opeenvolgende stappen, nauwkeurig kan opvolgen.

# De txt bestanden tonen echter maar één enkel oplossingstraject.
# Andere oplossingstrajecten,
# 	die bijvoorbeeld na toepassing van het tweede of het derde criterium
# 	een reductie van één µr,k opleveren,
# 	en dan al dan niet onmiddellijk de iteratiestap afbreken,
# 	en terugschakelen naar het eerste reductiecriterium,
# zijn even correct.

# Maandag 11 mei wordt een oplossing gepubliceerd.
# Daarmee wordt het oefeningengedeelte
# van het opleidingsonderdeel Besturingssystemen I afgesloten.


@buren=([-1,0],[+1,0],[0,-1],[0,+1]); 	# relatieve coördinaten van buurcellen
										# enige lijn die moet worden aangepast indien bijvoorbeeld ook/enkel diagnonale buren zouden mogen
$Y=0;
while(<>){
	chomp;
	@{$result[++$Y]} = map {$_>0 ? 0+$_ : undef} split; #als er een cijfer staat, dat opslaan anders undef
	unshift @{$result[$Y]},undef;		# nuttige indexering laten beginnen vanaf 1
	$X=$#{$result[$Y]} unless $X; 		# aantal kolommen
}
$XY=$X*$Y;

%todo=map {($_,undef)} 1..$XY;
for $y (1..$Y){
	for $x (1..$x){
		delete $todo {$result[$y][$x]} if $result[$y][$x]; #als het getal al in de numbrix staat dan moet je hem verwijderen van mogelijkheden
	}
}

@todo=map {($_,undef)} keys %todo; 		#een array versie van de hash: efficiënter bij initialisatie
for $y (1..$Y){
	for $x (1..$X){
		$mu[$y][$x]=($result[$y][$x] ? {$result[$y][$x],undef} : {@todo}); # is het vak ingevuld? indien niet, dan is alles in todo moglijk
	}
}

for my $y (1..$Y){
	print join " ", map {$result[$y][$_] ? sprintf "%03d", $result[$y][$_] : "..."} 1..$X;
	print "\n";
	@{$reeds_geprint_in_rooster[$Y]} = @{$result[$Y]};
}
print "\n";

$yield1=0;		#						 / 1 \
$yield2="";		# bijhouden of criterium   2   al dan niet nog nuttige opbrengst heeft 	
$yield3="";		#						 \ 3 /
$yield= 1;		# opbrengst laatst toegepast criterium continueert/beëndigt iteratie

while ($yield) {
	$yield = 0;


#					 __
#                   /  |
# reductiecriterium  | |
#					 | |
# 					 |_|

	for my $y (1 .. $Y){
		for my $x (1 .. $X){
			for my $w ( keys %{ $mu[$y][$x] } ) {
				my $w1 = ($w != 1 ? $w-1 : 2);
				my $w2 = ($w != $XY ? $w+1 : $XY-1);
				# voor 1 en $XY: makkelijker om tweemaal dezelfde test uit te laten voeren
				my ($n1,$n2)=(0,0);
				for (@buren) {
					my ($dy,$dx)=@{$_}; # hoeveel keer treedt waarde $w-1 op in de omliggende buren?
					$n1 += scalar( grep{ $_ == $w1} keys %{ $mu[$y+$dy][$x+$dx] });
						# hoeveel keer treedt waarde $w+1 op in de omliggende buren?
					$n2 += scalar( grep{ $_ == $w2} keys %{ $mu[$y+$dy][$x+$dx] });
						# veel simpelere oplossing dan met if testen te coderen!
						# je ook realiseren dat je pijnloos de mu's aanspreekt van "buren" buiten het rooster
						# strikte value checking zou specifieke code vereisen voor cellen aan de rand van het rooster
				}
				unless ($n1 && $n2){
					delete $mu[$y][$x]{$w};
					$yield++; # opbrengst in laatste iteratie over alle roostercellen
					$yield1++; # cumulatieve opbrengst in opeenvolgende iteraties van louter criterium 1
				}
			}
		}
	}
	next if $yield;
		# mu's uitprinten vooraleer opnieuw aan reductiecriteria 2 en 3 te beginnnen
		# enkel na geslaage (iteratieve) toepassing reductiecriterium
		# $yield1: nuttige opbrengst van criterium 1 tijdens deze iteratiestap
		# $yield2: en $yield2 en $yield3: opbrengst van criteria 2 en 3 in vorige iteratiestap
	if (($yield1 || $yield2 || $yield3) && keys %todo) {
		for my $y (1 .. $Y) {
			for my $x (1 ..$X) {
				unless ($result[$y][$x]) {
					# previous geeft voor elke cel het aantal elementen in de mu bij de vorige uitprint:
					# nodig om de cel te kunnen accentueren met een * als er iets gereduceerd kon owrden
					print "$y.$x",(!defined($previous[$y][$x])
									|| $previous[$y][$x]==scalar(keys %{$mu[$y][$x]}) ? "\t " : "\t* ")
									,(join " ", sort {$a <=> $b} keys %{$mu[$y][$x]}),"\n";
					$previous[$y][$x]=scalar(keys %{$mu[$y][$x]}); #aantal elementen die nog mogelijk zijn bepaalt in de vorige iteratie, zo kun je * erbij zetten indien het gereduceerd is
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
	$yield=1;
	while($yield){
		$yield=0;
		for my $y (1..$Y){
			for my $x (1..$X){
				if (keys %{ $mu[$y][$x]} == 1){ # indien er maar 1 mogelijkheid voor die cel overschiet
					my ($w) = keys %{ $mu[$y][$x]}; #die waarde ophalen
					if( exists $todo{$w}) { 
						delete $todo{$w}; # hem verwijderen uit de te verdelen cijfers
						for my $y0 (1..$Y){
							for my $x0 (1..$X){
								delete $mu[$y0][$x0]{$w} if ($x0!=$x || $y0!=$y); # van alle andere cellen het getal uit de mogelijkheden halen
							}
						}
						$result[$y][$x]=$w; #hem als definitieve waarde opslaan
						$yield2.=" ($y.$x=$w)" unless $reeds_geprint_in_rooster[$y][$x];
							# aangezien bij elke loop eerst het rooster nog eens wordt uitgeprint
							# en de geslaagde toepassing op een cel toch maar eenmaal gelogd moet worden
						$yield++;
							# loopen over louter criterium 2, zonder eerst criterium 1 toe te passen
					}
				}
			}
		}
	}

	if ($yield2) {
		print "\n# cel(len) met slechts 1 enkele kandiditaat:$yield2\n\n";
		for my $y (1..$Y) {
			print join " ", map {$result[$y][$_] ? sprintf "%03d",$result[$y][$_] : "..."} 1..$X;
			print "\n";
		}
		print "\n";
	}

	$yield = $yield2; 	# na cirterium 2 succesvol, opnieuw 1 vooraleer aan 3 te beginnen
	next if $yield2; 	# leidt tot efficiënter oplossingstraject

#                   ____
#                  |__ /
# Reductiecriterium |_ \
#                  |___/
#
	
	$yield3 = "";
	for my $w (sort keys %todo){
		$todo{$w}=[]; # todo values: kandidaatcellenverzameling (inverse van mu)
		for my $y (1..$Y){
			for my $x (1..$X){
				push @{$todo{$w}},[$y,$x] if exists $mu[$y][$x]{$w};
			}
		}
		if (@{$todo{$w}}==1){
			my ($y,$x) = @{$todo{$w}[0]};
			$result[$y][$x]=$w;
			%{$mu[$y][$x]}=($w,undef);
			$reeds_geprint_in_rooster[$y][$x]=1;
			$yield3.=" ($y.$x=$w)";
		}
	}

	if($yield3){
		print "\n# getal(len) slechts mogelijk in 1 enkele cel: $yield3\n\n";
		for my $y (1..$Y){
			print join " ", map {$result[$y][$_] ? sprintf "%03d",$result[$y][$_] : "..."} 1..$X;
			print "\n";
		}
		print "\n";
	}
	$yield=$yield3; # na eenmalige test over alle waarden
					# indine positief: volgend eiteratiestap over criteria 1,2,3
}

for my $y (1..$Y) {
	for my $x (1..$X){
		print "$y.$x: ",(join " ", sort {$a <=> $b} keys %{ $mu[$y][$x] }),"\n" unless scalar(keys %{ $mu[$y][$x] }) <= 1;

	}
}