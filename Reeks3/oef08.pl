#In reeks 2 vraag 35 werd besproken hoe je een hash kon inverteren. Veralgemeen deze methode, zodat je nu ook
#toelaat dat de originele hash duplikaten vertoont.

#if you cant a hash with non-unique values, you must use the techniques shown in vraag 8, that is build up a
#hash whose values ara a list of keys in the original hash

# %food-color as per the introduction
while (($food,$color) = each(%food_color)){
	push(@{$foods_with_color{$color}}, $food);
}

print "@{$food_with_color{yellow}} were yellow foods.\n";
