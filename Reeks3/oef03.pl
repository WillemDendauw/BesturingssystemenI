#Gebruik hashes van array's om aan elke index van de hash een lijst van waarden te associëren. Hoe kun je aan
#de lijst van een specifieke index een waarde toevoegen ? Hoe kun je de volledige lijst van waarden voor elke
#index tonen ?

#use refernces to arrays as the hash values, use push to append:

push(@{$hash{"keyname"} }, "new value");

#then, dereference the value as an array reference when printing out the hash:

foreach $string (keys %hash){
	print "$string: @{$hash{$string}}\n";
}


$hash{"a key"} = [ 3, 4, 5 ]; #anonymous array

@values = @{ $hash{"a key"}};

push @{ $hash{"a key"}} , $value;