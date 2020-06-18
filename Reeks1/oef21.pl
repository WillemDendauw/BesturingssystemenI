#Verwerk de elementen van een array in omgekeerde volgorde

@reversed = reverse @array

#of

foreach $element (reverse @array){
	#doe iets met $element
}

#of

for ($i = $#array; $i >= 0; $i--){
	#do something with $aray[$i]
}