#Verwerk de elementen van een hash in een gesorteerde volgorde,
#	hetzij alfabetisch of numeriek gesorteerd op de indices,
# 	hetzij alfabetisch of numeriek gesorteerd op de waarden,


@keys = sort { criterion( ) } (keys %hash);
foreach $key (@keys){
	$value = $hash{$key};
	#do something with $key, $value
}