#Verwerk een string karakter per karakter. Pas dit toe om:
	#een gesorteerde lijst uit te printen van alle karakters die minstens éénmaal in een string voorkomen.
	#van een bestand elk karakter individueel naar standaard uitvoer weg te schrijven, met telkens een kleine
		#tussenpause ertussen. Maak hierbij gebruik van de select functie om de pauzes te genereren. Stel ook
		#$| in op 1, om de output niet te laten bufferen.

@array = split(//,$string);

while (/(.)/g){
	# $1 has character, ord($1) it's number
}

%seen = ( );
$string = "an apple a day";
foreach $char (split //, $string){ #of while($string =~ /(.)/g)
	$seen{$char}++;
}
print "unique chars ar: ", sort(keys %seen),"\n";



#!/usr/bin/perl
$delay = ($ARGV[0] =~ /^-([.\d]+)/) ? (shift, $1) : 1;
$| = 1; #forces flush, not buffered
while(<>){
	for (split(//)){
		print;
		select(undef,undef,undef, 0.005 * $delay);
	}
}