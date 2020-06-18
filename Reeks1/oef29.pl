#Bepaal de waarden van elementen die in een eerste array voorkomen, maar niet in een tweede. Pas dit toe
#om lijnen van een bestand te filteren die niet voorkomen in een ander bestand.

#hash maken van keys van array B en dat als lookuptable gebruiken

#standaard

%seen = ( );
@aonly = ( );

foreach $item (@B) {
	$seen{$item} = 1;
}

foreach $item (@A) {
	unless ($seen{$item}){
		push(@aonly,$item);
	}
}

#idiomatic

my %seen;
my @only;

@seen{@B} = ( );

foreach $item (@A) {
	push(@aonly, $item) unless exists $seen{$item};
}

#loopless

my @A = ... ;
my @B = ... ;
my %seen;
@seen{@A} = ( ); #gebruik elementen van A als keys van seend
delete @seen {@B};
my @aonly = keys %seen