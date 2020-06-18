#Veronderstel dat je over twee hashes beschikt. Bepaal enerzijds de indices die in beide hashes,
#en anderzijds de indices die slechts in één van beide hashes voorkomen.

my @common = ( );
foreach (keys %hash1){
	push(@common,$_) if exists $hash{$_};
}

my @this_not_that = ( );
foreach (keys %hash1){
	push(@this_not_that, $_) unless exists $hash2{$_};
}