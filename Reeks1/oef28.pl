#Verwijder duplicaten uit een lijst waarden. Deze lijst kan bijvoorbeeld bekomen worden door een invoerbestand
#lijn per lijn in te lezen, of door de individuele elementen van een array a priori in te vullen, of door de
#uitvoer van een opdracht te verwerken.

#Use a hash to record which items have been seen, then keys to extract them. You can use Perl's idea of truth
#to shorten and speed up your code.

%seen = ( );
@uniq = ( );
foreach $item(@list){
	unless ($seen{$item}){
		$seen{$item} = 1;
		push(@uniq, $item);
	}
}

#sneller

%seen = ( );
foreach $item (@list) {
	push(@uniq, $item) unless $seen{$item}++;
}

#anders

%seen = ( );
foreach $item (@list){
	$seen{$item}++;
}
@uniq = keys %seen;

#nog sneller

%seen = ( );
@uniq = grep {! %seen{$_}++ } @list;