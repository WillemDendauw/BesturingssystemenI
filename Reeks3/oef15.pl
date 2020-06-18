# De algemene techniek om te sorteren, die reeds in reeks 2 vraag 29 besproken werd, kan zondermeer gebruikt worden om te
# sorteren op één of andere functieberekening op de waarden van de sorteren elementen. Om de sortering te versnellen, is het
# dikwijls aangewezen om deze functieberekeningen slechts éénmaal, a priori, uit te voeren voor alle elementen, en de resultaten
# ervan tijdelijk op te slaan. Voer deze methode bijvoorbeeld uit om een array te sorteren op de lengte van de elementwaarden.
# Probeer hierbij om zo weinig mogelijk intermediaire datastructuren te gebruiken. Test in eerste instantie uit op het aantal
# overwinningen bestand, zoals in de inleidende demonstratie getoond. Open dit PowerPoint bestand (ook beschikbaar op Ufora) in
# de Show Presenter View van Slide Show. .


# Lees het bestand lijn per lijn in,
# in de opeenvolgende elementen van een array.
# en print, ter controle, deze array uit.
# De uitvoer staat in deze reeks slides rechts,
# telkens in de grijze zone.

# Elke lijn bevat drie velden, van elkaar gescheiden door kommapunten:
# de naam van een alpijns skiester of skiër,
# haar/zijn nationaliteit,
# en het aantal overwinningen in de wereldbeker die zij/hij behaald heeft.
# Exclusief resultaten in seizoen 2019-2020.

# Blijkbaar zijn de lijnen op naam gesorteerd.
# Dat doet er niet toe.
# Sowieso is een andere sorteervolgorde gewenst:
# in eerste instantie op de nationaliteit,
# en vervolgens in dalende volgorde op het aantal overwinningen.

# We hebben geen pointers nodig om dit te coderen.
# ……


# …… 
# dankzij een sorteercriterium op maat.
# Oefening op reeks 1.

# Resultaat is OK.

# Toch steekt er een performantieprobleem de kop op.

# Het gebruik van de sort functie is wel eenvoudig,
# maar de sort van perl gaat nogal domweg te werk:
# sort blijft koppels lijnen omwisselen,
# zolang er geen koppels lijnen meer moeten omgewisseld worden.
# De uitvoeringstijd is bijgevolg kwadratisch in functie van het aantal lijnen.

# Het aantal keren, dat de split functie moet uitgevoerd worden, ook.
# Dat kan veel erger zijn.

# Kunnen we niet beter ervoor zorgen dat
# dit aantal keren precies gelijk is aan het aantal lijnen ?
# Uiteraard.
# Het resultaat van de split van elke lijn moet dan echter bewaard worden.
# In wat anders dan anonieme array's, voor elke lijn één ?
# Vandaar zit deze oefening in reeks 3.

# Laten we dat eens uitvoeren, en uitprinten,
# in eerste instantie zonder de impact op het sorteercriterium te bekijken.
# ……


# ……
# Pointers uitprinten geeft het verwachte scheef antwoord.

# Om opnieuw de inhoud van de lijnen uit te printen,
# in plaats van de pointers naar anonieme array's,
# waarin de opgesplitste velden bewaard worden, ……


# ……
# moeten we eerst de pointer ontpointen,
# en kunnen we daarna gebruik maken van de join functie,
# om de velden aan elkaar te plakken.

# Nu nog het sort criterium aanpassen.

# In plaats van lijnen om te wisselen,
# op basis van velden na opsplitsing,
# wisselen we pointers om,
# naar array's waar de eenmalig opgesplitste velden
# netjes opeenvolgende velden zijn.
# ……


# ……
# ontpointen,
# en indexeren met het veldnummer.

# Resultaat is opnieuw OK.
# Uitvoering is veeeel sneller.

# Misschien nog ietsje proberen te versnellen.
# Focus op dat terug aan elkaar plakken van de velden,
# nu nog altijd via een join.

# We kunnen dat vermijden door,
# aangezien we toch voor elke lijn een anonieme array ingevoerd hebben,
# aan die anononieme array een extra veld toe te voegen ……


# ……
# die telkens de originele lijn, niet-opgesplitst, bevat.

# Sorteren zelf blijft omwisselen van pointers,
# op basis van velden in het begin van de corresponderende array's,
# zal even snel blijven gebeuren.
# Extra veld achteraan wordt bij sort gewoon genegeerd.

# Terug de lijn reconstrueren is nu veel simpeler.
# Lijn zit gewoon in het laatste veld.
# Gaat wel ten koste van noodzakelijke geheugenhoeveelheid.
# Is nu grosso modo twee keer zo groot.

# Ook handig als er op reguliere expressies zou moeten gesplitst worden,
# in plaats van op één enkele delimiter, hier een kommapunt.
# Om dan de oorspronkelijke lijn te reconstrueren,
# zou je in de anonieme array ook de scheidingsstrings moeten opnemen.
# Kan wel, door de reguliere expressie in het eerste argument van split,
# volledig te taggen tussen ronde haakjes.
# Ook hier heb je dan extra geheugenopslag nodig.

# Deze laatste slide (oorspronlijke lijn extra in anonieme array) is niet echt cruciaal.
# Wel belangrijk is het principe van sorteren van pointers naar anonieme arrays,
# waarin zo veel mogelijk bewerkingen éénmalig uitgevoerd worden.
# Dit benadert meer een lineaire in plaats van een kwadratische uitvoeringstijd,
# in functie van het aantal te sorteren elementen.
# Het sorteren via de sort functie van perl, blijft op zich kwadratisch.


@ARGV = ("overwinningen.txt");

@s = <>;

print 
	
	map { $_->[-1] }

	sort {
		$a->[1] cmp $b->[1]
				or 
		$b->[2] <=> $a->[2]
	}

	map { [ (split /;/,$_), $_ ]}

@s;


#customizable comparison routine in sort
@ordered = sort { compare( ) } @unordered;

#you can speed this up by precomputing the field.

@precomputed = map { [ compute( ),$_] } @unordered;
@ordered_precomputed = sort { $a->[0] <=> $b->[0] } @precomputed;
@ordered = map { $_->[1] } @ordered_precomputed;

#and finally, you can combine the three steps:

@ordered = map { $_->[1] }
			sort { $a->[0] <=> $b->[0] }
			map { [compute( ), $_] }
			@unordered;


#complexere tests maken

@employees = (
	{
		ssn 	=> ...,
		name	=> ...,
		salaray => ...,
		age 	=> ...
	},
	.
	.
	.
);
@ordered = sort {$a->{name} cmp $b->{name} } @employees;

#in een foreach

foreach $employee (sort {$a->{name} cmp $b->{name} } @employees) {
	print $employee->{name}, " earns \$", $employee->{salary}, "\n";
}

# if you're going to do a lot of work with elements in a particular order, it's more efficient to sort once and work from that:

@sorted_employees = sort { $a->{name} cmp $b->{name} } @employees;
foreach $employee (@sorted_employees) {
	print $employee->{name}, " earns \$", employee->{salary}, "\n";
}

#load %bonus
foreach $employee (@sorted_employees) {
	if($bonus{ $employee->{ssn} } ){
		print $employee->{name}, " got a bonus!\n";
	}
}


# multiple comparisons

@sorted = sort { $a->{name} cmp $b->{name}
							||
				$b->{age} <=> $a->{age} } @employees;


# real life example of sorting

use User::pwent qw(getpwent);
@users = ( );
# fetch all users;
while (defined($user = getpwent)) {
	push(@users, $user);
}
@users = sort { $a->name cmp $b->name } @users;
foreach $user (@users) {
	print $user->name, "\n";
}

# nog meer sort

@sorted = sort { substr($a,1,1) cmp substr($b,1,1) } @names;

@sorted = sort { length $a <=> length $b } @strings;


# remove bottleneck by running the operation once per element prior to the sort, use map to store the result of the opration
# in an array whose elements are anonymous arrays containing both the computed field and the original field. Then we sort this
# array of arrays on the precompute field ans use map to get the sorted original data. This map-sort-map concept is useful and common.

@temp	= map 	{ [ length $_, $_ ] } @strings;
@temp	= sort 	{ $a->[0] <=> $b->[0] } @temp;
@sorted = map 	{ $_->[1] } @temp;

# we hebben de lengte van iedere string slechts 1x berekend. Nu plaatsen we het in 1 statement

@sorted = 	map { $_->[1] }
			sort { $a->[0] <=> $b->[0] }
			map { [ length $_, $_ ] }
			@strings; 


# ingewikkelder voorbeeld:

@temp 			= map 	{ [ /(\d+)/, $_ ] } @fields;
@sorted_temp 	= sort 	{ $a->[0] <=> $b->[0] } @temp;
@sorted_fields 	= map 	{ $_->[0] } @sorted_temp;

# of in 1

@sorted_fields 	= 	map 	{ $_->[1] }
					sort 	{ $a->[0] <=> $b->[0] }
					map 	{ [ /(\d+)/,$_ ] }
					@fields;

# last example

print 	map { $_->[0] } #whole line
		sort {
			$a->[1] <=> $b->[1] #gid
					||
			$a->[2] <=> $b->[2] #uid
					||
			$a->[3] <=> $b->[3] #login
		}
		map { [ $_, (split /:/)[3,2,0] ] }
		'cat /etc/passwd';


















