#Stel een nieuwe hash samen op basis van meerdere bestaande hashes. Hou, in tegenstelling tot reeks 2 vraag 37,
#nu wel rekening met indices die in meerdere originele hashes voorkomen. Probeer ook het herhalen van de
#while-lus, voor elk van de hashes, van de oorspronkelijke oplossing te vermijden.

#in reeks 2 vraag 37, the while and assignment code was duplicated. Here's a sneaky way to get around that:

foreach $substanceref (\%food_color, \%drink_color){
	while (($k,$v) = each %$substanceref){
		$substance_color{$k} = $v;
	}
}

#if we're emrgin hashes with duplicates, we can inset our own code to decide what to do with those duplicates:

foreach $substanceref (\%food_color, \%drink_color){
	while (($k,$v) = each %$substanceref){
		if(exists $substance_color{$k}){
			print "Warning: $k seen twice. Using the first definition.\n";
			next;
		}
		$substance_color{$k} = $v;
	}
}