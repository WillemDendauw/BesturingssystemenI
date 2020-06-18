# Verwerk eerst de inleidende demonstratie (ook beschikbaar op Ufora). Open dit PowerPoint bestand in de Show Presenter View van
# Slide Show. Volg de aanwijzingen erin strikt, vooraleer je aan de opgave begint. De SVG-bestanden 05.svg, 10.svg, 20.svg, 40.svg,
# 80.svg en 310.svg stellen labyrinten voor. Geef (zoals in 05.txt, 10.txt, 20.txt, 40.txt, 80.txt en 310.txt) een overzicht van de
# mogelijke overgangen tussen buurcellen.
# 	Kleur in de SVG-bestanden het pad tussen ingang en uitgang.
# 	Enkele te reproduceren resultaten: 10.svg en 310.svg.


# De svg bestanden tonen in een browser een doolhof, 
# met een rechthoekig rooster van cellen.
# Sommige doorgangen tussen naburige cellen blijven open,
# terwijl andere doorgangen geblokkeerd zijn door rechtlijnige wanden.
# Er zijn ook wanden voor nagenoeg alle cellen aan de vier randen van het rooster.
# Voor twee randcellen, de uitgangen naar de omgeving,
# in het voorbeeld van de slide, cellen 41 en 294,
# blijft een opening tot de omgeving.

# Het is in deze oefening niet alleen de bedoeling om de locatie van de wanden,
# zowel die tussen naburige cellen, als die aan de randen van het rooster,
# uit het svg bestand te parsen,
# en te transformeren in een perl datastructuur,

# Maar ook, louter op basis van deze perl datastructuur,
# een pad te zoeken in het doolhof, die de twee uitgangen
# met elkaar verbindt,
# uiteraard enkel door gebruik te maken
# van open doorgangen tussen naburige cellen.

# Bovendien moet het svg bestand zodanig aangepast worden,
# dat het geconstrueerde pad in de figuur gekleurd wordt.

# De naam van het svg-bestand wordt als enig argument
# bij de uitvoering van het script meegegeven. 
# ……


# ……
# Een svg bestand uit lijnen tekst.
# Dat wordt meteen duidelijk als je het bestand opent in een editor.
# De diverse lijnen tekst coderen op een of andere manier
# de informatie die door een browser als figuur weergegeven wordt.

# Hier zijn de bestanden programmatisch gegenereerd,
# en ondermeer hierdoor strikt geformatteerd.
# Bovendien is elk elementair informatie-item gecodeerd op een afzonderlijke lijn.
# Het verwerken van het bestand in slurp modus,
# biedt dan ook geen enkel voordeel.
# Uiteraard is het de bedoeling om deze informatie-items
# uit de individuele lijnen te parsen, met behulp van reguliere expressies.
# Aangezien de lijnmodus volstaat, en de informatie op elke lijn
# zowel beperkt als strikt geformatteerd is,
# is er geen enkele reden om de g modifier te gebruiken.

# In dit svg bestand mogen de eerste lijnen tot en met het <rect>-element,
# genegeerd worden (rode arcering op slide).

# Na het <title>-element komen er twee opeenvolgende <g>-elementen,
# met elk een specifieke weergavetaak.

# Zo omvat het tweede <g>-element <text>-elementen,
# die de numerieke identificatie µ van de individuele cellen weergeven.
# Dit is louter bedoeld als visuele leidraad en hulp bij het construeren en debuggen van jouw oplossing.
# Bij de verwerking van het bestand moet het tweede <g>-element volledig genegeerd worden.
# ……


# ……
# Via het <title>-element kan je het aantal rijen en kolommen
# van het rooster bepalen.

# Eens je dit #rijen en #kolommen kent, kan je, voor elke cel,
# meteen bepalen welke zijn potentiële buurcellen zijn,
# zonder met de wanden rekening te houden.

# Je zou voor de identificatie van de cellen
# een tweedimensionale indexering kunnen gebruiken.
# Het derde <g>-element identificeert echter de cellen ééndimensionaal,
# met een integer µ tellend vanaf 1, waarbij de cellen rij per rij aan bod komen,
# en in elke rij kolom per kolom.
# De cel linksbovenaan heeft µ=1, de cel rechtsonderaan µ=#rijen.#kolommen

# Het is aangewezen om ook de omgeving,
# het gebied rondom het rooster te identificeren.
# Hiervoor kan je best de conventie µ=0 gebruiken.

# Voor het bijhouden van de buurcellen gebruik je een array,
# geindexeerd van 0 tot #rijen.#kolommen.
# Elk arrayelement heeft als value een pointer naar een anonieme array,
# met vier elementen, bijvoorbeeld [µboven,µlinks,µrechts,µonder].
# Dat voor elke buur in een specifieke richting een vaste index wordt gekozen,
# is wel belangrijk,
# de volgorde van de diverse richtingen niet.
# Voor cellen in de hoeken van het rooster, zullen twee van de vier µ's ingesteld moeten worden op 0, de omgeving.
# Voor de andere cellen aan de rand van het rooster, zal dit het geval zijn voor één enkele µ van de vier.
# Voor inwendige cellen geldt steeds:
# µboven=µ-#kolommen,
# µlinks=µ-1,
# µrechts=µ+1,
# µonder=µ+#kolommen.

# Alhoewel ook de omgeving, µ=0, een element heeft in de burenarray,
# heeft het geen zin om voor dit element een anonieme array te initialiseren.
# Laat de value voor [0] op undef staan.
# ……


# ……
# Ter controle kun je best de inhoud van de burenarray
# op de console uitprinten,
# en vergelijken met wat in het overeenkomstige txt bestand staat,
# Hierin worden ook de volgende stappen van het oplossingstraject gelogd.

# Op formattering na moet je precies hetzelfde bekomen.
# Pas dan ga je verder met de volgende stap.
# ……


# ……
# Vervolgens moet je de individuele <line>-elementen 
# van het tweede <g>-element verwerken.

# Deze geven aan welke overgangen gesloten zijn. 

# Haal de x1, y1, x2 en y2 attributen uit de <line>-elementen,
# en deel deze integers door de schalingsfactor 16.

# Je bekomt hierdoor de coördinaten (x1, y1) en (x2,y2) van de eindpunten van een wand,
# of van een aantal opeenvolgende wanden, in elkaars verlengde.
# Breek die opeenvolging van wanden dan eerst nog op in individuele fragmenten.
# x identificeert een kolom, y een rij, 
# ten opzichte van de linkerbovenhoek van de figuur.

# Bepaal uit de eerste coördinaat, (x1, y1), welke de identificatie µ van de cel is,
# die (x1, y1) linksboven als hoekpunt heeft,
# en bepaal eveneens de corresponderende µboven en µlinks.
# Je zal hiervoor een eenvoudige berekening moeten uitvoeren,
# met enkel nog#rijen en #kolommen als ingrediënt.

# Indien y2=y1 (en dan zal x2=x1+1),
# dan bevindt de wand zich aan de bovenzijde van de cel,
# en zullen de cellen µ en µboven
# uit elkaars burenverzameling moeten geëlimineerd worden:
# µboven als bovenbuur uit de burenverzameling van µ, 
# en, tenzij µboven=0, µ als onderbuur uit de burenverzameling van µboven. 

# De term elimineren zou ik voorlopig niet implementeren als effectief verwijderen,
# maar eerder als aanduiden dat de corresponderende overgang gesloten is.
# Vervang bijvoorbeeld de µ of µboven value door undef.
# ……


# ……
# Indien x2=x1 (en dan zal y2=y1+1),
# dan bevindt de wand zich aan de linkerzijde van de cel,
# en zullen de cellen µ en µlinks
# uit elkaars burenverzameling moeten geëlimineerd worden:
# µlinks als linkerbuur uit de burenverzameling van µ, 
# en, tenzij µlinks=0, µ als rechterbuur uit de burenverzameling van µlinks. 

# Pas nadat alle <line>-elementen verwerkt zijn,
# kuis je alle anonieme array's wat op,
# door alle elementen met undef waarden ook effectief te verwijderen.

# Er is dan immers geen voordeel meer om voor elke buur in een specifieke richting
# een vaste index in de anonieme array te behouden.

# Vervang de anonieme array's meteen door anonieme hashes.
# Dat zal de volgend fase wat makkelijker maken.

# Elke burenverzameling zal nu minimaal uit 1 en maximaal uit 4 elementen bestaan.
# ……


# ……
# Ter controle geef je opnieuw de huidige inhoud van de burenarray
# op de console weer,
# en vergelijk je met wat in het overeenkomstige txt bestand staat.

# Op formattering en sortering na, moet je precies hetzelfde bekomen.
# Pas dan ga je verder met de volgende stap.
# ……


# ……
# Precies twee cellen blijken de omgeving, µ=0, als buur te bezitten.
# Hoe nu het kortste pad construeren tussen deze twee uitgangen ?
# In dit kortste pad mogen geen deeltrajecten voorkomen
# die heen en terug bezocht worden. 

# Simpele iteratieve procedure.
# Om deze te illustreren worden vanaf nu op de slide
# alle cellen met een burenverzameling rood gekleurd.

# Vooraleer de iteratie van start gaat,
# zijn alle cellen rood gekleurd.

# In elke iteratie:

# ga je na of er cellen zijn, µ', wiens burenverzameling
# slechts uit één enkele cel, µ", bestaat.

# voor elk dergelijk (µ',µ") koppel:

# 1. verwijder je µ' uit de burenverzameling van µ".
# Begrijp je nu waarom er overgeschakeld is op anonieme hashes ?

# 2. verwijder je de burenverzameling van µ'.
# Doe dit door de pointer naar de anonieme hash door undef te vervangen.
# ……


# ……
# blijf itereren,
# ……


# ……
# En geef bij elke iteratie op de console weer,
# van welke cellen je de burenverzameling verwijderd hebt.

# Vergelijk met wat in het overeenkomstige txt bestand staat.
# Op formattering en sortering na, moet je precies hetzelfde bekomen
# ……


# ……
# blijf itereren,

# tot wanneer er geen enkele cel µ' meer kan gevonden worden,
# wiens burenverzameling slechts uit één enkele cel bestaat.

# De cellen die op het kortste pad liggen tussen de twee uitgangen,
# zijn precies deze die nog een burenverzameling hebben.

# Hun burenverzameling zal telkens uit exact twee elementen bestaan.
# ……


# ……
# Ter controle geef je nog een laatste keer de huidige inhoud van de burenarray
# op de console weer,
# en vergelijk je met wat in het overeenkomstige txt bestand staat.

# De twee uitgangen hebben, als enige cellen, µ=0 in hun burenverzameling.

# Op formattering en sortering na, moet je precies hetzelfde bekomen.
# Pas dan ga je verder met de volgende stap.
# ……


# ……
# Geef, op het standaard uitvoerkanaal,
# de lijst weer van opeenvolgende cellen langs het kortste pad,
# nu in de volgorde van een stapsgewijze wandeling tussen de twee uitgangen.
# Vergelijk opnieuw met het in het txt-bestand vermelde resultaat.

# En als laatste stap……


# ……
# Zorg ervoor dat het svg-bestand het kortste pad correct weergeeft.

# Dit kan je eenvoudig doen door,
# onmiddellijk na het <title>-element,
# een extra <g>-element, op te nemen,
# waarin elke individuele cel door een <polyline>-element gekleurd wordt.

# Het <points>-attribuut van dit element moet telkens ingevuld worden met de coördinaten,
# van de vier hoekpunten van de cel,
# in een willekeurige, maar wel cyclische correcte volgorde.

# Om het bestand te wijzigen zal je het een tweede keer moeten verwerken,
# nu in read/write modus.
# De gemakkelijkste manier om dit te doen,
# is door de $^I variabele in te stellen.

# Maandag 4 mei wordt een oplossing gepubliceerd.

# In die oplossing zal een wat andere manier gebruikt worden om
# bij het parsen van wanden de burenverzamelingen te reduceren.

# De op slides 3-6 beschreven methode is eenvoudiger,
# en volstaat zeker in deze oefening.
# De alternatieve manier is gericht op veralgemening, om ook 
# doolhoven met een niet-rechthoekig rooster aan te pakken.

# Hetgeen volgt dan ook pas verwerken, als je zelf eerst de meer
# eenvoudige manier hebt geïmplementeerd.

# Toch ernstig bekijken, en uitproberen, al is het maar om
# overtuigd te worden dat je niet bang moet zijn
# om meerdimensionale indexering in te voeren,
# als dat beter in uw kraam past.
# ……


# ……
# Alternatieve methode:

# Bij verwerking van het <title>-element niet alleen, voor elke cel,
# bepalen welke zijn buurcellen zijn.
# maar ook welke de coördinaten van de eindpunten van alle mogelijke randen zijn.
# Dit gebeurt zonder slag of stoot door een extra datastructuur randen in te voeren.
# Deze wordt vierdimensionaal geïndexeerd, $rand{$x1}{$y1}{$x2}{$y2} ,
# en heeft als waarde een pointer naar een anonieme tabel van twee elementen,
# Beide elementen verwijzen dan naar een van beide buurcellen,
# en telkens welk type rand het voor die buurcel is.
# In ons rechthoekig rooster bijvoorbeeld,
# zal een linkerrand voor de ene cel een rechterrand zijn voor de andere,
# en zal een bovenrand voor de ene cel een onderrand zijn voor de andere.

# Dit betekent uiteraard in eerste instantie wat meer codeerwerk.

# De verwerking van de <line>-elementen versimpelt echter.
# Je kan onmiddellijk de geparste coördinaten als indexering hanteren
# in de randen hash, en te weten komen welke soort buur je uit de burenverzameling
# van beide cellen moet verwijderen.

# Bovendien is het nu veel eenvoudiger om doolhoven met een andere topologie aan te pakken,
# zoals in een hexagonaal rooster, ……


# …… of in een cairo tessalation, mijn favoriet, geïllustreerd.
# Hier zijn de cellen vijfhoeken, afwisselend vertikaal en horizontaal uitgerokken.


@ORGV = @ARGV;

while(<>) {
	if (m[<title>([0-9]+) by ([0-9]+).*</title>]) {
		($X,$Y)=($1,$2);
		last;
	}
}

for $y (1..$Y){
	for $x (1..$X) {
		$z = ($y-1)*$X+$x;

		# @buren: geïndexeerd door celnummer -> lijst van vier buren

		$buren[$z][0] = ($y==1 ? 0 : $z-$X); #eerste rij 0 de rest huidig getal - aantal kolommen
		$buren[$z][1] = ($x==1 ? 0 : $z-1);
		$buren[$z][2] = ($x==$X ? 0 : $z+1);
		$buren[$z][3] = ($y==$Y ? 0 : $z+$X);

		# %rand: geïndexeerd door coördinaten uiteinden
		# -> 2D tabel cellen en locatie rand tov corresponderende cel
		$x1=$x; #linkbovenhoekpunt van je cel
		$x2=$x+1;
		$y1=$y;
		$y2=$y+1;
		push @{$rand{$x1}{$y1}{$x2}{$y1}},[$z,0]; #bovenrand
		push @{$rand{$x1}{$y1}{$x1}{$y2}},[$z,1]; #linkerrand
		push @{$rand{$x2}{$y1}{$x2}{$y2}},[$z,2]; #rechterrand
		push @{$rand{$x1}{$y2}{$x2}{$y2}},[$z,3]; #onderrand
	}
}


print "\n# Burenlijst (hindernissen negerend):\n\n";

for $z (1..$#buren){
	print "$z:\t";
	print join "\t",@{$buren[$z]};
	print "\n";
}

while(<>){
	push @lijnen, [$1,$2,$3,$4] if /(?:line x1=")([0-9]+)(?:" y1=")([0-9]+)(?:" x2=")([0-9]+)(?:" y2=")([0-9]+)/;
}

$width = 16;
for (@lijnen) {
	($a,$b,$c,$d) = @{$_};
	($a,$b,$c,$d)=($c,$d,$a,$b) if ($a>$c);
	($a,$b,$c,$d)=($c,$d,$a,$b) if ($a==$c && $b>$d);
	$_/=$width for ($a,$b,$c,$d);
	$dx = $c-$a;
	$dy = $d-$b;
	$dx/=abs($dx) if $dx;
	$dy/=abs($dy) if $dy;
	$x1 = $a;
	$y1 = $b;

	do{
		$x2 = $x1 + $dx;
		$y2 = $y1 + $dy;
		for (@{$rand{$x1}{$y1}{$x2}{$y2}}){
			$buren[$_->[0]][$_->[1]]=undef; #indien buur niet meer bereikbaar dan undef gezet in burenlijst van het vak
		}
		($x1,$y1)=($x2,$y2);
	} until ($x2==$c && $y2==$d);
}

print "\n# Burenlijst (rekening houdend met hindernissen:\n\n";

for $z (1..$#buren){
	# voor elke cel: vervanging tabel van vier buren door hash met overblijvende buren

	$buren[$z]={ map {$_,undef} grep {defined $_} @{$buren[$z]}}; #buren[$z] bevat anonieme array van 0 tem 3. $_ bevat 0..3
	print "$z:\t";
	print join "\t",sort {$a <=> $b} keys %{$buren[$z]};
	print "\n";
}

print "\n# Eindcellen in opeenvolgende iteraties:\n\n";

while(1){
	# @eindcellen = cellen met elk slechts 1 effectieve buur

	@eindcellen=grep {keys %{$buren[$_]} == 1} grep {defined $buren[$_]} 1..$#buren; #van alle vakjes die minstens 1 buur hebben, uiteindelijk cijfer van 0 tem 3 die toont welke buur ze nog hebben
	last unless @eindcellen; #indien eindcellen leeg is wil het zeggen dat ze allemaal 2 buren hebben en het doolhof opgelost is
	print "- @eindcellen\n";

	for my $z1 (@eindcellen) {
		my ($z2) = keys %{$buren[$z1]}; #$z2 is de buur, dus het hokje dat als volgende 1 buur zal hebben
		delete $buren[$z2]{$z1}; #verwijder de eindcel uit de lijst van de voorlaatste
		$buren[$z1]=undef; #verwijder de volledige burenlijst van de laatste cel
	}
}

print "\n# Burenlijst na eliminatie doodlopende paden:\n\n";

for $z (1..$#buren){ #alle hokjes overlopen
	next unless $buren[$z]; #tot je een vind met een buur (of ja 2 buren, dus een cel die behoort tot de oplossing)
	print "$z:\t"; 
	print join "\t", keys %{$buren[$z]}; #de buur die hij heeft
	print "\n";
}

print "\n# Pad:\n\n";

$z2=0;
while(++$z2) { #opsporen 1 van de 2 uitgangen
	next unless defined( $buren[$z2] );
	last if ((grep {$_==0} keys %{$buren[$z2]}) > 0); #als de cel een buur met cijfer 0 heeft (een cel buiten rooster)
}

@pad=();
$z1=0;
while(1){
	push @pad,$z2; #voeg de cel toe aan het pad
	delete $buren[$z2]{$z1}; #delete de vorige cel uit de lijst van buren van $z2
	$z1 = $z2; #stel $z1 gelijk aan de huidige cel
	($z2)=keys %{$buren[$z2]}; #stel z2 aan de volgende cel (zijn enige buur nog)
	last unless $z2; #stop indien $z2 0 is (en dus buiten het veld valt)
}
print "@pad\n";

@ARGV = @ORGV;
undef $/;
$^I=".bak"; # $^I is de current value ofthe inplace-edit exentsion
$_=<>; #verwerken in r/w modus
/(.*<\/title>.)(.*)/s; #bepaling locatie waar extra <g> element moet komen
print "$1 <g fill=\"#FF0000\" stroke=\"none\">\n";

while( $_=pop @pad){
	$z=$_-1;
	$x1=($z%$X+1)*$width;
	$x2=$x1+$width;
	$y1=(int($z/$X)+1)*$width;
	$y2=$y1+$width;

	print "		<polygon points=\"$x1,$y1 $x2,$y1 $x2,$y2 $x1,$y2\" />\n";
}

print "	</g>\n$2";