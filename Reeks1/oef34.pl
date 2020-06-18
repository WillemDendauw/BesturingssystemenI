#Hoe kun je de inhoud van een hash tonen, waarbij een duidelijk onderscheid gemaakt wordt tussen de indices
#en hun corresponderende waarden. Eenvoudige pogingen zoals print"%hash" of print %hash blijken niet te voldoen.

while (($k,$v) = each %hash) {
	print "$k => $v\n";
}

#map gebruiken om een list van strings te genereren

print map { "$_ => $hash{$_}\n"} keys %hash;

#tijdelijk de $, variabele veranderen naar een spatie en dan de hash printen

{
	local $, = " ";
	print %hash
}