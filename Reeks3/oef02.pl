#Op welke verschillende manieren kun je een scalaire variabele invullen met een referentie naar een array ?
#Hoe kun je via deze referentie:
#	een specifiek element van de array aanspreken ?
#	een slice van de array aanspreken ?
#	het laatste indexnummer bekomen ?
#	het aantal elementen in de array bekomen ?
#	een array element achteraan toevoegen ?
#	de array element per element verwerken ?


#to get areerence to an array:

$aref			= \@array
$anon_array		= [1, 3, 5, 7, 9];
$anon_copy		= [ @array ];
@$implicit_creation = (2,4,6,8,10);

#to dereference an array reference, precede it with an at sign (@):

push(@$anon_array, 11);

#or use a pointer arrow plus a bracketed subscript for a particular element

$two = $implicit_creation->[0];

#To get the last index number by reference, or the number of items in that referenced array:

$last_idx = $#$aref;
$num_items = @$aref;

#or defensively embracing and forcing context:

$last_idx = $#{ $aref };
$num_items = scalar @{ $aref };

#To iterate through the etnire array, loop with foreach or for:

foreach $tiem ( @{$array_ref}) {
	# $item has data
}

for ($idx = 0; $idx <= $#{ $array_ref}; $idx++){
	# $array_ref->[$idx] has data
}

