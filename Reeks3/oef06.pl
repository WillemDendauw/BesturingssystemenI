#In reeks 2 vraag 20 werden een paar technieken gehanteerd om de inhoud van een hash te tonen. Je kan
#bijvoorbeeld een intermediare array invoeren waarin je de volledige hash opslaat, om deze dan ineens
#uitprinten. Pas dit nu toe met behulp van een anonieme array, om een expliciete intermediare array te
#vermijden.

#use a temporary array variable to hold the hash, and then print that:

%hash = ("key1" => 1, "key2" => 2, "key3" => 3);

{
	my @temp = %hash;
	print "@temp\n";
}

#or use an @{[ ]} anonymous aray dereference to interpolate the hash as a list:

print "@{[%hash]}\n";


