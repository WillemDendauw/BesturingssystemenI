#Schrijf het skelet van een filterprogramma. Indien op de opdrachtlijn parameters worden meegegeven,
#dan moeten deze beschouwd worden als de namen van de inputbestanden. Indien er geen parameters zijn,
#dan moet het programma zijn invoer van de standaard invoer halen. Een parameter "-" duidt aan dat de
#standaard invoer als één van de inputkanalen moet verwerkt worden. Een parameter van de vorm
#"opdracht |" laat toe om de uitvoer van een ander programma als invoer te beschouwen.

while (<>) {
	#do something with the line
}

#wordt vertaalt in

unshift(@ARGV, "-") unless @ARGV; #- is anders voor standaardinvoer
while ($ARGV = shift @ARGV) {
	unless (open(ARGV,$ARGV)) {
		warn "Can't open $ARGV: $!\n";
		next;
	}
	while(defined($_ = <ARGV>)) {
		# ...
	}
}

#arg demo 1: optionele -c vlag
if(@ARGV && $ARGV[0] eq "-c") {
	$chop_first++;
	shift;
}

#arg demo 2: -number vlag
if(@ARGV && $ARGV[0] =~ /^-(\d+)$/) {
	$columns = $1;
	shift;
}

#arg demo 3: Prcoess clustering -a, -i, -n or -u flags
while(@ARGV && $ARGV[0] =~ /^-(.+)/ && (shift, ($_ = $1), 1)) {
	next if /^$/;
	s/a// && (++$append,	redo);
	die "usage: $0 [-ainu] [filenames] ...\n";
}

#$/ is de lineterminator, dus als er geen is, lees je het volledige bestand in
#$. is het lijnnummer, dit wordt nooit gerest. Als je dat wel wil moet je close ARGV if eof toevoegen

undef $/;
while(<>){
	#$_ is nu het volledige bestand
}

{
	local $/; #local to the block
	while(<>){
		#doe iets
		#functies die worden opgeroepen, gebruiken undeffed versies
	}
}