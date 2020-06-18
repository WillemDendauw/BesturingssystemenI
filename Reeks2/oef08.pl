#Verwerk een bestand woord per woord, bijvoorbeeld om een frequentietabel te construeren met een teller
#voor elk optredend woord.

%seen = ( );

while(<>){
	for $chunk (split) {
		$seen{$chunk}++;
	}
}

while(<>){
	while( /(\w[\w'-]*)/g){
		$seen{$chunk}++;
	}
}

foreach $word ( sort { $seen{$b} <=> $seen{$a} } keys %seen){
	printf "%5d %s", $seen{$line}, $line;
}