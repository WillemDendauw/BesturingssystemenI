#Achterhaal het eerste element van een array, en zijn index, dat aan een specifieke voorwaarde voldoet.

my ($match, $found, $item); #privaat attribuut

foreach $item (@array) {
	if (criteria){
		$match = $item;
		$found = 1;
		last;
	}
}
if($found){
	#do iets met $match
}
else {
	#unfound
}

#om het met index te doen

my($i, $match_index);
for($i=0; $i < $#array; $i++){
	if(criteria){
		$match_index = $i;
		last;
	}
}

if(defined $match_index){
	##found in $array^[$match_index]
}
else {
	#unfound
}