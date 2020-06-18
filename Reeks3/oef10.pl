#Het is eenvoudig om met een hash hiërarchische verbanden met een boomstructuur tussen entiteiten te vertolken: het volstaat
#om voor elke kind-ouder koppel, een element in de hash toe te voegen, met als index de kind-entiteit, en als waarde de
#ouder-entiteit. In dit adjacency model is het niet alleen eenvoudig om van een kind-entiteit de ouder-entiteit te bepalen,
#maar ook om van een ouder-entiteit de kinderen te achterhalen. Door als waarden in de hash anonieme array's te gebruiken,
#kun je ook verwijzen naar meerdere kind-entiteiten. Pas dit model toe om de staatsstructuur van België voor te stellen.
#Bestudeer eerst de inleidende demonstratie (ook beschikbaar op Ufora). Open dit PowerPoint bestand, zoals de inleiding tot
#referenties, in de Show Presenter View van Slide Show. Volg de aanwijzingen erin strikt, vooraleer je verder werkt.
#	Je kan van deze techniek ook gebruik maken om in een verzameling include-bestanden achtereenvolgens:
#	voor ieder bestand een lijst te construeren van bestanden die dit bestand includeren,
#	de bestanden te achterhalen die wel andere bestanden includeren, maar waarnaar niet verwezen wordt vanuit andere include-bestanden.

#In deze oefening beschikken we over een bestand, regios.csv,
#waarin informatie staat over de gewesten, de provincies,
#de arrondissementen en de gemeenten (voor de laatste fusies) van ons land.
#Elke lijn bevat informatie over één entiteit (regio).
#Elke lijn heeft vier attributen, van elkaar gescheiden door een kommapunt:
#de naam van de regio,
#de naam van de onmiddellijke ouderentiteit (gemeente < arrondissement < provincie < gewest < land),
#het bevolkingsaantal (enkel indien het een gemeente betreft),
#de oppervlakte (enkel indien het een gemeente betreft).

#Je mag veronderstellen dat de lijn van een ouderentiteit eerder in het bestand aan bod komt, dan zijn kindregio's.

#Het bestand kan rechtstreeks in Excel ingelezen worden (zie rechterfractie van de slide).
#Hier is het echter de bedoeling om de informatie te verwerken in een of andere perl datastructuur,
#en daarna, om te bewijzen dat dit gelukt is,
#enkele vragen te beantwoorden, louter op basis van de datastructuur.

#Lees het bestand lijn per lijn in.
#Om een record te creëeren, dat uit een aantal velden bestaat,
#creëer je voor elke lijn een anonieme array of hash.
#……


#……
#Je mag zelf beslissen of je kiest voor een array  of een hash.
#Indien je kiest voor een hash, dan kan je de attributen aanspreken met een passende string als index,
#zoals {"naam"}, {"ouder"}, ..., {"oppervlakte"},
#of zelfs {naam}, {ouder}, ..., {oppervlakte}.
#Indien je kiest voor een array, dan neemt dit minder geheugen in beslag,
#maar moet je zelf een mapping bijhouden,
#voor het verband tussen een nummer (de index in de array)
#en de betekenis van het corresponderend veld,
#[0] betekent bijvoorbeeld naam, [1] ouder, .... 

#In ieder geval heb je in elk record minstens evenveel  elementen nodig als de regio attributen heeft.
#Dat is hier niet voldoende.
#Je moet voor elke regio ook over een veld beschikken, kinderen,
#die de hiërarchie van regio's in de omgekeerde zin duidelijk maakt:
#elke regio heeft een ouderregio, en kan de ouder zijn van meerdere kindregio's.
#Het kinderen veld zal hierdoor moeten ingevuld worden
#met een pointer naar een anonieme array.

#Je mag ook nog andere extra velden invoeren,
#mocht dit het antwoord op de uiteindelijke vragen vergemakkelijken.
#Je zal dat in deze oefening minstens twee keer kunnen doen.

#Het creëren van een anonieme array  of hash heeft maar zin,
#als je de terugkeerwaarde van […] of {…}, de pointer, persistent bewaart.
#Daarom creëer je, voor elke anonieme entiteit, een element in een overkoepelende hash, %H,
#met als index de regionaam, en als value de pointer.

#Het lijkt misschien overbodig om de regionaam redundant op te slaan,
#éénmaal als index in %H,
#nog eens in een veld van het overeenkomstige record.
#Dat is maar een tijdelijke situatie.
#Nu moeten we, hoe dan ook, de pointers persisteren,
#en ervoor zorgen dat we, via de regionaam, de overige attributen kunnen te weten komen.
#Dankzij %H zijn beide problemen ineens aangepakt.

#Het eerste record, voor Belgie, bevat weinig informatie
#……


#……
#Dat wordt al wat meer indien we een gewestlijn verwerken.
#Nu moeten we het ouderveld alvast instellen met een verwijzing naar de ouderentiteit,
#voor gewestlijnen telkens Belgie.
#We zouden het ouderveld kunnen invullen met de naam van de ouderentiteit.
#Laten we niet te simplistisch doen.
#Liever fysieke verwijzingen dan logische.
#Via %H kunnen we de naam omvormen in de pointer naar het ouderrecord,
#en deze in het ouderveld opnemen (groene pijlen).
#Dat zal alvast geheugenplaats besparen,

#Voor elk verwerkte gewestlijn, weten we nu dat de overeekomstige ouder,
#er een kind bij heeft gekregen.
#We kunnen dan ook het kinderenveld ervan aanvullen,
#correcter geformuleerd, de anonieme array waar het kinderenveld naar point,
#aanvullen met …
#niet de naam van de kindregio,
#dat zou opnieuw simplistisch zijn,
#maar met de pointer naar de zopas gecreëerde anonieme array  of hash. (rode pijlen).

#We kunnen deze procedure toepassen voor elk van de drie gewesten van ons land.
#……


#……
#Nu komen provincieiijnen aan bod.
#De procedure blijft totaal ongewijzigd.
#Het ouderveld van het nieuwe record wordt ingesteld op de pointer naar het ouderrecord,
#hier een of ander gewest,
#terwijl de anonieme array, waar hetkinderenveld van dit ouderrecord naar wijst,
#wordt aangevuld met de pointer  naar het nieuwe kindrecord (rode pijlen).

#We moeten niets specifieks doen voor provincieiijnen ten opzichte van gewestlijnen.
#Dat zal ook zo zijn voor
#……


#……
#de arrondissementslijnen,
#……


#……
#en de gemeentelijnen.

#Ons programma zal geen rekening moeten houden met de aard  van de regio,
#of die nu een gewest , een provincie, een arrondissement of een gemeente is,
#en kan dit tijdens de verwerking van de bestandslijnen zelfs niet eenvoudig te weten komen.
#……


#……
#Behalve voor de gemeentelijnen,
#dan zal iets extra's kunnen gebeuren.

#Bij gemeentelijnen zijn zowel het bevolkingsaantal als de oppervlakte wel ingevuld.
#Aangezien  een gemeente in een arrondissement ligt,
#een arrondissement in een provincie ligt,
#een provincie in een gewest ligt, 
#een gewest in het land Belgie ligt,
#moet zowel het bevolkingsaantal als de oppervlakte van een gemeente worden opgeteld
#bij de corresponderende aantallen van alle hogerliggende regio's waarin de gemeente ligt.
#Om dit te doen is een iteratie noodzakellijk, tot wanneer je het record tegenkomt,
#dat geen ouderrecord heeft. Belgie.

#Een analoge procedure kan aangewend worden,
#om in elk record een  extra veld bij te werken,
#dat het totale aantal gemeenten in die regio bevat.
#Te onthouden voor straks.
#……


#……
#Alle recordstructuren hangen in een boomstructuur aan elkaar.
#We kunnen zowel naar hogere niveau's navigeren, via de groene pijlen,
#als naar diepere niveau's, via de rode pijlen,

#Naar elke record wordt verwezen,
#vanuit diepere records (tenzij voor gemeenterecords)
#en/of vanuit hogere niveau's (tenzij voor het Belgie record).
#In ieder geval minstens eenmaal.

#Er is dan ook geen nood meer om de persistentie van de pointer
#artificiëel te verzorgen vanuit de overkoepelende %H.

#De naam van een regio moet ook niet meer per se als value in de %H hash bewaard worden,
#aangezien de record hiervoor zelf een naamveld heeft.
#Van in het begin werd aangegeven dat dit redundante informatie was,
#waar we liever van af zouden willen geraken.

#Conclusie: de overkoepelende %H is compleet overbodig.

#Oppassen geblazen.

#Als %H inderdaad verwijderd wordt,
#dan blijft de volledige boomstructuur wel aan elkaar hangen,
#en zal er geen garbage collection plaats vinden,
#maar we hebben geen enkel entrypoint meer tot de boomstructuur,
#geen toegangspoort meer tot de informatie.

#Vooraleer %H verwijderd wordt,
#moet één enkele pointer als entrypoint bewaard worden.
#Maakt niet uit naar waar in de boomstructuur die pointer wijst.
#Uit symmetrieoverwegingen bijvoorbeeld de pointer naar de root, Belgie.

#Eens toegang tot één record van de boomstructuur,
#geraken we aan alle informatie door de rode en/of groene pijilen te volgen.
#……


#……
#Tijd voor een eerste oefening,
#ter bevestiging dat de constructie van de boom geslaagd is.

#Vertrek van de pointer naar Belgie.
#Geef een oplijsting van alle attributen van Belgie.
#Uiteraard wordt verwacht dat je niet botweg  pointers uitprint,
#ik heb het over het kinderen attribuut,
#maar, in dat geval, de namen van alle kinderen.

#Detecteer vervolgens het specifieke kind dat aan een of ander criterium voldoet,
#bijvoorbeeld het grootste bevolkingsaantal heeft.

#Voer op dat kind iteratief dezelfde procedure toe,
#die je op Belgie hebt toegepast,
#tot wanneer je een regio tegenkomt,
#die kinderloos is,
#in het administratief jargon een gemeente genoemd.

#Je moet bijgevolg exact dezelfde uitvoer krijgen als op de slide getoond,
#inclusief het aantal gemeenten.

#Niet verder gaan vooraleer je deze uitvoer kan reproduceren,
#snel genoeg,
#en zonder naar de oplossing te spieken.

#Daarna pas tijd voor
#……


#……
#een tweede oefening:

#Vertrek opnieuw van de pointer naar Belgie.
#We hebben niet anders.

#Produceer een netjes geformatteerde hiërarchische uitvoer van alle informatie in de boomstructuur,
#exact zoals op de slide partiëel getoond.

#Hoe dieper het niveau, hoe meer de naam moet inspringen.
#Denk er a priori aan, hoe je dat zal kunnen realiseren.

#De records moeten in eerste instantie diepte-eerste gesorteerd worden:
#alle kinderen moeten zo kort mogelijk na het ouderrecord vermeld worden.
#Siblings, kinderen van dezelde ouder, moeten vervolgens aflopend gesorteerd worden volgens hun bevolkingsaantal.

#Je denkt misschien in eerste instantie aan recurcieve subroutines.
#Ja maar, …, je mag, maar moet geen subroutines kunnen gebruiken,
#en je bent misschien zelfs bang van recursiviteit.

#Recursiviteit kan hier,
#en ook in veel andere situaties,
#op een iteratieve manier worden geëmuleerd.

#Veel minder gevoelig voor fouten,
#mocht je het mij vragen.

#Algemene programmeertechniek, op zich niets met perl te maken.

#Je moet wel kunnen beschikken over een stapel- of queue-mechanisme.

#Perl heeft dat gelukkig: gewone arrays,
#die je niet expliciet indexeert,
#maar louter manipuleert via de pop en push, of de shift en unshift functies.
#……


#……
#De iteratieve methode om een diepte-eerst 
#aflopen van een hiërarchie te realiseren,
#bestaat uit een:

#Een initialisatie:
#plaats de root van de structuur als enige op de queue.

#Een iteratie tot wanneer de queue volledig leeg is.

#Bij elke iteratie:
#haal je het eerste (of het laatste) element van de queue,
#verwerk je de gegevens ervan,
#en plaats je al haar/zijn eventuele kinderen langs dezelfde kant (vooraan of achteraan) op de queue.
#De volgorde waarin je de kinderen op de queue plaatst,
#kan hierbij van belang zijn.
#De kinderen zullen immers in de omgekeerde volgorde verwerkt worden.

#Tijdens deze procedure hoef je je niet aan te trekken,
#waar ergens in de boomstructuur je je bevindt.
#Je kan het trouwens ook niet eenvoudig te weten komen.

#Ongeloofwaardig ?

#De slide stelt opeenvolgende fases in het iteratieproces voor.
#Een vertikale balk toont telkens een actuele toestand van de queue.

#Initialisatie: Belgie als enige in de queue.

#Iteratie 1: Belgie van queue, gegevens uitprinten, en kinderen Gew.Brussel, Wallonie en Vlaanderen  erop.

#Iteratie 2: Vlaanderen van queue, gegevens uitprinten, en kinderen  Limburg, Vlaams-Brabant, West-Vlaanderen, Oost-Vlaanderen en Prov.Antwerpen erop.

#Iteratie 3: Prov.Antwerpen van queue, gegevens uitprinten, en kinderen  Arr.Mechelen, Arr.Turnhout en Arr.Antwerpen erop.

#Iteratie 4:  Arr.Antwerpen van queue, gegevens uitprinten, en kinderen  Schelle…Antwerpen erop.
#……


#……
#Iteratie 5:  Antwerpen van queue, gegevens uitprinten, geen kinderen om aan queue toe te voegen.
#…
#Iteratie 34:  Schelle van queue, gegevens uitprinten, geen kinderen om aan queue toe te voegen.

#Na alle gemeenten van het vorige arrondissement verwerkt te hebben,
#komt nu het volgende arrondissement van dezelfde provincie te voorschijn.
#Niet dat we daar ons bewust van zijn tijdens de verwerking.
#Iteratie 35: Arr.Turnhout van queue, gegevens uitprinten, en kinderen Baarle-Hertog…Turnhout erop.

#Iteratie 36:  Turnhout van queue, gegevens uitprinten, geen kinderen om aan queue toe te voegen.
#…
#Iteratie 62:  Baarle-Hertog van queue, gegevens uitprinten, geen kinderen om aan queue toe te voegen.

#Iteratie 63: Arr.Mechelen van queue, gegevens uitprinten, en kinderen Sint-Amands…Mechelen erop.
#……


#……
#Iteratie 64:  Mechelen van queue, gegevens uitprinten, geen kinderen om aan queue toe te voegen.
#…
#Iteratie 76:  Sint-Amands van queue, gegevens uitprinten, geen kinderen om aan queue toe te voegen.

#Nadat alle gemeentes van alle arrondissementen van de vorige provincie verwerkt zijn,
#komt nu de volgende provincie van hetzelfde gewest te voorschijn.
#Niet dat we daar ons bewust van zijn tijdens de verwerking.
#Iteratie 77: Oost-Vlaanderen van queue, gegevens uitprinten, en kinderen Arr.Oudenaarde…Arr.Gent erop.

#Iteratie 78: Arr.Gent van queue, gegevens uitprinten, en kinderen Moerbeke…Gent erop.

#Iteratie 79:  Gent van queue, gegevens uitprinten, geen kinderen om aan queue toe te voegen.
#…
#Iteratie 99:  Moerbeke van queue, gegevens uitprinten, geen kinderen om aan queue toe te voegen.

#Demonstatie heeft lang genoeg geduurd.
#Tegen dat we met de uitleg aan iteratie 645 zitten,
#is de coronacrisis voorbij.

#Iteratie 645:  Koekelberg, gegevens uitprinten, geen kinderen om aan queue toe te voegen, queue leeg.

#Kan mij niet voorstellen dat je het nog steeds niet kan geloven.
#Verkies je toch traditioneel recursief te werken ?
#Mij niet gelaten.
#Je doet maar.
#Als je er maar voor zorgt dat de uitvoer correct is.

#Zoals bij de eerste oefening:
#blijven loopen tot wanneer je de geweste uitvoer kan reproduceren,
#snel genoeg,
#het gaat immers maar om drie lijntjes code,
#en zonder naar de oplossing te spieken.

#Daarna overschakelen naar oefening 12.


@ARGV = "regios.txt";
while(<>){
	chomp;
	( $regio, $ouder, $population, $area ) = split ";";
	$hash{$regio} = {	regio 		=> $regio,
						ouder 		=> $hash{$ouder},
						kinderen 	=> [],
						number		=> 0,
						niveau		=> 0,
						population 	=> $population,
						area   		=> $area};

	push @{ $hash{$ouder}->{kinderen}}, $hash{$regio};
	$refouder = $hash{$regio}->{ouder};
	$hash{$regio}{niveau} = $refouder->{niveau}+1;
	next unless $population;

	while ($refouder){
		$refouder->{number}		+= 1;
		$refouder->{population} += $population;
		$refouder->{area}		+= $area;
		$refouder = $refouder->{ouder};
	}
}

$refknoop = $hash{Belgie}; #initialisatie voor controle 1
@refqueue = ($refknoop); #initialisatie voor controle 2
%hash = (); #hash niet meer nodig!

#controle 1: hierarchielijn vanaf Belgie, met telkens kind met grootste population

while ($refknoop) {
	print "knoop:		", $refknoop->{regio}, "\n";
	print "kinderen 	", join( " ", map { $_->{regio} }
									sort { $a->{regio} cmp $b->{regio} }
									@{ $refknoop->{kinderen} } ), "\n";
	print "#gemeenten 	", $refknoop->{number}, "\n";
	print "population:	", $refknoop->{population}, "\n";
	print "area:		", $refknoop->{area},"\n";
	print "\n";
	($refknoop) = sort { $b->{population} <=> $a->{population} } @{ $refknoop->{kinderen} };
}

#controle 2: volledige hierarchie vanaf Belgie

while($refknoop = shift @refqueue) {
	printf "%-41s %8d %6d\n",(("	"x($refknoop->{niveau}-1)).$refknoop->{regio}),$refknoop->{population},$refknoop->{area};
	unshift @refqueue, sort { $b->{population} <=> $a->{population} } @{ $refknoop->{kinderen} };
}