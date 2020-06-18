#Op welke manieren kun je elk index-waarde paar van een hash element per element verwerken?
#Hou er rekening mee dat verwerken in gesorteerde volgorde al dan niet gewenst is.

#each en while

while (($key,$value) = each (%hash)) {
	#do iets met $key en $value
}

#of

foreach $key (keys %hash) {
	$value = $hash{$key};
	#doe iets met $key en $value
}