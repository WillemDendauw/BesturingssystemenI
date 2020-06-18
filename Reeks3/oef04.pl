#Op welke verschillende manieren kun je een scalaire variabele invullen met een referentie naar een hash.
#Hoe kun je via deze referentie:
#	een specifiek element van de array aanspreken ?
#	een slice van de hash aanspreken ?
#	alle indices bekomen ?
#	alle index-waarde koppels één voor één verwerken ?

#to get a hash reference:

$href = \%hash;
$anon_hash = { "key1" => "value1", "key2" => "value2" };
$anon_hash_copy = { %hash };

#to dereference a hash reference:

%hash = %$href;
$value = $href->{$key};
@slice = @$href{$key1, $key2, $key3};
@keys = keys %$href;

#To check wether something is a hash reference:

if (ref($someref) ne "HASH"){
	die "expected a hash refrence, not $someref\n";
}

#this example prints out all keys and values from two predefined hashes:

foreach $href ( \%ENV, \%INC ) { 		#OR: for $href ( \(%ENV,%INC)) {
	foreach $key ( keys %$href ) {
		print "$key => $href->{$key}\n";
	}
}


#access slices of hashes by refrence as you'd access slices of arrays by reference. For example:

@values = @$hash_ref{"keys1", "key2", "key3"};

for $val (@$hash_ref{"key1", "key2", "key3"}) {
	$val += 7; #add 7 to each value in hash slice
}