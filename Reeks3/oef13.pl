#Op welke manier (met welk formaat, ...) kun je best een datastructuur, zoals opgebouwd in vraag 11, in een tekstbestand
#opslaan, en terug inlezen?

#use a simple file format with one field per line:

#	FielName: Value

#seperate records with blank lines

foreach $record (@array_of_records) {
	for $key (sort keys %$record) {
		print "$key: $record->{$key}\n";
	}
	print "\n";
}


$/ = ""; #paragraph read mode
while(<>){
	my @fields = split /^([^:]+):\s*/m;
	shift @fields; #for leading null field
	push (@array_of_records, { map /(.*)/, @fields}); #?? {} omdat we een nieuwe anonymous hash maken
}