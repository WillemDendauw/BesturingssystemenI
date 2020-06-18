#Het gedrag van een perl programma kan door de gebruiker ervan beïnvloed worden door parameters op de
#opdrachtlijn te vermelden, of door environment variabelen te interpreteren. Het invullen van
#configuratiebestanden vormt een ander alternatief. Hoe kunnen deze configuratiebestanden best gestructureerd
#en verwerkt worden ?

while(<CONFIG>){
	chomp;
	s/#..*//;
	s/$^\s+//;
	s/\s+$//;
	next unless length;
	my ($var,$val) = split(/\s*=\s*/,$_,2); #2 is in hoeveel stukken het mag gesplitst worden
	$user_pref{$var} = {$val};
}