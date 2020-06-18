#Op het examen van het vak Computernetwerken I wordt dikwijls volgende vraag gesteld:
#Een ISP is eigenaar van een IP supernetwerkadresbereik ... . Een aantal van zijn klanten, die respectievelijk
#subnetwerkadresbereiken ... voor hun intranet benutten, sluiten zich aan bij een andere ISP, zonder hun
#infrastructuur te hernummeren. Met welke, zo klein mogelijke verzameling netwerkadressen, in
#prefixlengtesyntax, moeten de routingtabellen van het Internet verwijzen naar het resterende adresbereik van
#de ISP ? Deze netwerkadressen mogen niet overlappen, noch onderling, noch met de subnetwerkadresbereiken van
#de klanten.

#Ontwikkel een script dat dit probleem behandelt. Het script verwacht als opeenvolgende argumenten eerst het
#(enige) supernetwerkadres van de ISP, en vervolgens een willekeurig aantal subnetwerkadressen van muterende
#klanten, bijvoorbeeld:
#	200.25/16 200.25.16/21

#Controleer dat de prefixlengtes van elk van de argumenten aan de vereiste minimumwaarden voldoen. Het script
#moet als uitvoer de op adres gesorteerde verzameling overblijvende netwerkadressen produceren:
#	200.25/20 200.25.24/21 200.25.32/19 200.25.64/18 200.25.128/17

#Wordt het script met volgende parameters opgeroepen,
#	141.96/12 141.99.88/23 141.99.160/21 141.103.66/27

#dan moet volgende verzameling overblijvende op adres gesorteerde netwerkadressen geproduceerd worden:
#	141.96/15 141.98/16 141.99/18 141.99.64/20 141.99.80/21 141.99.90/23 141.99.92/22
#	141.99.96/19 141.99.128/19 141.99.168/21 141.99.176/20 141.99.192/18 141.100/15
#	141.102/16 141.103/18 141.103.64/23 141.103.66.32/27 141.103.66.64/26 141.103.66.128/25
#	141.103.67/24 141.103.68/22 141.103.72/21 141.103.80/20 141.103.96/19 141.103.128/17 141.104/13

#Bestudeer eerst de analyse van een oplossingsmethode. Open dit PowerPoint bestand (ook beschikbaar op Ufora)
#in de Show Presenter View van Slide Show. Volg de aanwijzingen erin vooraleer je aan de uitwerking van de
#oplossing werkt.


# ……
# Het aantal subnetwerkadressen, van muterende klanten, vormt een verzameling,
# in de volgende slides rood gekleurd.
# Zal een subnetwerkadres dan ook kortweg een rode noemen.

# Laten we ook voor het enige supernetwerkadres, van de ISP,
# ook een verzameling invoeren,
# ook al zit er in die verzameling slechts één enkel element.
# Zal veranderen.
# In de volgende slides blauw gekleurd.
# Zal een supernetwerkadres dan ook kortweg een blauwe noemen.

# Voor elke rode passen we achtereenvolgens een eenvoudige procedure toe,
# tot wanneer er geen enkele rode meer overblijft.
# ……


# ……
# Ga voor een specifieke rode na of er een blauwe bestaat waar de rode deel van uitmaakt.
# rood  blauw
# (ontbrekend font ? blokje betekent deelverzameling van, al dan niet gelijk).

# Door de volgende stappen in de iteratie correct toe te passen,
# zullen we er zeker van kunnen zijn,
# dat er ofwel geen enkele blauwe hieraan voldoet,
# ofwel één enkele.

# Indien er geen enkele blauwe hieraan voldoet:
# Verwijder de rode uit zijn verzameling,
# en begin de volledige procedure opnieuw.

# Indien er wel een dergelijke blauwe is, ……


# …… en blijkt dat rood  blauw (rood  blauw),
# splits dat de blauwe op in twee helften.
# (ontbrekend font ?  ene blokje betekent deelverzameling van, maar zeker niet gelijk
# ander blokje verschillend van).

# Uiteraard weten we nu dat de rode deel zal uitmaken ()
# van één van die twee helften.
# Daar gaan we ons echter niet mee bezighouden.
# Dit leidt weliswaar tot enig performantieverlies,
# maar, aangezien de volledige procedure
# in enkele µs wordt uitgevoerd,
# is dit niet echt een probleem.
# We kunnen het ons hier veroorloven te kiezen voor eenvoud van coderen,
# in plaats van optimalisatie van performantie.

# We laten de rode gewoon in zijn verzameling zitten,
# en beginnen de procedure volledig opnieuw.
# De rode zal later wel opnieuw aan bod komen.

# Waarschijnlijk zelfs onmiddellijk opnieuw,
# afhankelijk hoe je de rode verzameling implementeert. 

# Hoe dan ook, je vergeet in elke iteratie,
# wat je de vorige iteratie hebt uitgespookt,
# en voert de iteratie slaafs opnieuw uit.

# Dus opnieuw op zoek gaan naar de blauwe
# waar de rode deel van uitmaakt.
# ……


# ……
# En als je die blauwe gevonden, en blijkt dat rood  blauw (rood  blauw),
# niet aan elkaar gelijk,
# splits dat de blauwe opnieuw op in twee helften.

# Begin hierna volledig opnieuw.

# Blijf die iteratie,
# waarschijnlijk op steeds dezelfde rode,
# herhalen tot ……


# ……
# rode = blauw blijkt.

# Verwijder in dat geval zowel rood als blauw uit hun respectievelijke verzamelingen.

# Begin daarna de procedure volledig opnieuw.
# ……


# ……
# Nu op een andere rode.

# Indien er geen rode meer overblijven,
# dan bevat de blauwe verzameling de gevraagde netwerkadressen.

# Simpel.
# Toch nog een aantal probleempjes oplossen,
# vooraleer we aan het coderen beginnen.
# ……


# ……
# Zowel de rode, als de blauwe verzameling moet in een perl datastuctuur bewaard worden.

# Arrays of Hashes ?

# Van zodra je in een verzameling op zoek moet gaan naar een element,
# en je dat element daarna dan op een eenvoudige manier wil verwijderen,
# moet je in eerste instantie aan hashes denken.
# Met de keys, exists en delete functies beschikken we immers over fantastische wapens,
# die veel codeerwerk kunnen simplificeren.

# In eerste instantie. Meestal. Niet altijd.

# Hier zijn er een aantal argumenten die niet in het voordeel van hashes pleiten:

# 1.Het zoekcriterium is niet rood = blauw, maar rood  blauw.
# (ontbrekend font ? blokje betekent deelverzameling van, al dan niet gelijk).

# 2. Op de volgende slides zal blijken dat we de rode en blauwe elementen
# door pointers naar anonieme … zullen voorstellen.  
# De indices van een hash moeten echter scalaire waardes zijn.
# Pointers als indices mogen absoluut niet. Als values uiteraard wel.
# Daar zijn we hier niet veel mee.

# 3. De uitvoer moet numeriek gesorteerd worden.
# De keys functie produceert een niet geordende lijst.
# Het sorteren zal dan achteraf,
# in een sort {…} op maat moeten uitgevoerd worden.
# Indien we arrays gebruiken, kunnen we ervoor zorgen
# dat de blauwe verzameling bij elke individuele manipulatie,
# verwijdering van een element,
# en eventuele vervanging door twee helften,
# steeds gesorteerd blijft.
# De moeite die we moeten doen om de blauwe verzameling te sorteren
# is er steeds, maar op een ander tijdstip, en anders te implementeren.
# Bij gebruik van arrays tijdens de constructie,
# bij gebruik van hashes na de constructie.

# Sortering van de rode verzameling is totaal overbodig.
# ……


# ……
# Elk netwerkadres bestaat steeds uit twee elementen:
# 1.het eerste ip-adres uit het bereik.
# 2.de prefixlengte, of wat ermee equivalent is,
# het aantal elementen in het netwerkbereik.

# Het aantal elementen in de blauwe verzameling,
# zal tijdens uitvoering van het programma continu variëren.

# We kunnen toch moeilijk expliciete namen gaan invoeren
# voor elk netwerkadres dat opduikt.

# Conclusie: anonieme arrays met telkens twee elementen.
# ……


# ……
# Een IPv4 adres is een 32-bit getal, dat we op diverse manieren kunnen representeren.

# De keuze wordt best bepaald door de eenvoud
# waarmee de twee in ons programma noodzakelijke acties
# zullen kunnen geïmplementeerd worden:
# 1. bevat blauw rood ?
# 2. hak blauw in twee helften.

# Drie opties.

# 1.Dotted decimal representatie. vier getallen <256.
# Al 50 jaar gebruikt voor menselijke communicatie.
# Zou hier betekenen dat we voor elke netwerkadres
# anonieme array van 5 elementen hebben i.p.v. 2.
# Op zich niet erg.
# Erger is dat we, afhankelijk van de prefixlengte,
# de vier getallen specifiek, niet uniform, moeten behandelen.

# 2.Binaire representatie.
# Uniforme behandeling, onafhankelijk van prefixlengte.
# Vereist stringmanipulaties voor beide acties.

# 3.De numerieke waarde van het getal zelf.
# Van een pleonasme gesproken.
# Uniforme behandeling, onafhankelijk van prefixlengte.
# Vereist bewerkingen met integers voor beide acties.

# Ik kies voor de derde optie.
# Tweede optie is ook goed te doen.
# Maak zelf uw keuze.
# ……


# ……
# We zullen dikwijls de prefixlengte van een netwerkadres, integer <33,
# moeten converteren in het aantal elementen ervan, integer <4294967296,
# en terug.

# Best a priori eenmalig 2 conversietabellen initialiseren, met elk 33 elementen.

# Hiervoor Arrays of hashes gebruiken ?

# Van prefixlengte naar aantal elementen:
# Welk voordeel zouden we met een hash hebben ?
# Geen enkel.
# Array bijgevolg.

# Van aantal elementen naar prefixlengte:
# We willen geen 4294967296 geheugenplaatsen reserveren,
# waarvan slechts 33 benut.
# Hash bijgevolg.
# ……


# ……
# Indien voor de optie gekozen wordt waarbij een netwerkadres
# voorgesteld wordt door [startgetal,aantal],

# Dan moet de modulobewerking startgetal % aantal
# nul opleveren.

# Anders geen geldig netwerkadres.

# Simpel.
# ……


# ……
# Indien voor de optie gekozen wordt om de netwerkadressen
# voor te stellen door [start1,aantal1] en [start2,aantal2],
# en beide voldoen aan de geldigheidstest van de vorige slide,

# dan geldt [start2,aantal2]  [start1,aantal1] als
# (ontbrekend font ? blokje betekent deelverzameling van, eventueel gelijk)
# aan drie voorwaarden voldaan is:

# aantal2  aantal1
# start1  start2
# start2+aantal2  start1+aantal1
# (ontbrekend font ? blokjes betekenen alle driekleiner dan of gelijk).

# De laatste twee voorwaarden impliceren de eerste.

# Opnieuw simpel.
# ……


# ……
# Indien voor de optie gekozen wordt de netwerkadressen
# voor te stellen door [start,aantal],
# dan worden de netwerkenadressen van de twee helften bekomen door:

# [start,aantal/2]
# [start+aantal/2,aantal/2]

# Opnieuw simpel.
# ……


# ……
# Specifiek element van een array verwijderen,
# en eventueel vervangen door twee andere elementen.

# Koren op de molen van de slice functie.
# ……


# ……
# Hoog tijd om aan de codering te beginnen.

# Vermijd spieken naar de oplossing,
# of poog dit tenminste toch zolang mogelijk uit te stellen.

# Daarna zeker nog oefening 15 aanpakken.



$aantal = 1/2;

#mapping prefixlengte <=> aantal adressen
for my $prefix (reverse 0 .. 32){
	$aantal *= 2;
	$aantal[$prefix] = $aantal;
	$prefix{$aantal} = $prefix;
}

$error = 0;

for $net ( @ARGV ){
	@ip = split /[.\/]/,$net;					# 4bytes netwerkadres + 1 byte prefixlengte
	#splice ARRAY,OFFSET,LENGTH,LIST 			# vervang in array vanaf offset en met lengte length door list
	splice @ip,(@ip-1),0,(0)x(5-@ip) if @ip<5; 	# eventueel aanvullen met 0 bytes
	$start = 0;
	$start = $start * 256 + $ip[$_] for 0 .. 3; # compacte representatie netwerkadres (een volledig getal)
	if ($start%$aantal[$ip[4]]) {				# berekening minimale prefixlengte
		$ip[4]++ while $start%$aantal[$ip[4]];
		print "$net vereist minimaal /$ip[4]\n";
		$error++;
	}
	@v = ([$start,$aantal[$ip[4]]]) unless @v;	# initialiseren verzameling supernets
}

exit(0) if $error;

shift @ARGV; 									# meegeven supernet verwijderen uit array
while (@ARGV){
	$sub=$ARGV[0]; 								# eerstvolgende subnetwerk
	@ip = split /[.\/]/,$sub;
	splice @ip,(@ip-1),0,(0)x(5-@ip) if @ip<5;
	$start=0;
	$start=$start*256+$ip[$_] for 0..3;
	print "$start\n";
	my $ind=-1;
	my $found=0;
	for $super (@v){							# welk supernet bevat subnet?
		$ind++;
		if ($start>=$super->[0] && $start<$super->[0]+$super->[1]){ # als het in het het bereik van het supernet ligt: ok
			$found=1;
			if($aantal[$ip[4]]==$super->[1]){ 	# als het subnet == supernet, dan moet je het supernet verwijderen
				splice @v,$ind,1;				# verwijderen
				shift @ARGV;					# volgende subnet
			}
			elsif($aantal[$ip[4]]<$super->[1]){ # supernet opsplitsen indien het groter aantal mog heeft dan sub
				$helft = $super->[1]/2;
				splice @v,$ind,1,([$super->[0],$helft],[$super->[0]+$helft,$helft]);
			}
			last;
		}
	}
	shift @ARGV unless $found;
}

for $v (@v) {
	@ip = ();
	for $b (reverse 0..3) {
		$ip[$b] = $v->[0]%256;
		$v->[0] -= $ip[$b];
		$v->[0] /= 256;
	}
	pop @ip while (@ip>1 && !$ip[-1]);
	print join (".",@ip),"/$prefix{$v->[1]}\n";
}
