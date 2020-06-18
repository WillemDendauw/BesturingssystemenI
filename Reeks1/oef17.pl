#Schrijf de elementen van een willekeurige array uit op één enkele lijn, waarbij tussen alle opeenvolgende
#elementen een komma geplaatst wordt, en het voegwoord "en" tussen het voorlaatste en het laatste element.

@array = ("red","yellow","green");
print "I have ", @array, " marbles.\n"; #alle elementen aan elkaar geplakt
print "I have @array marbles.\n"; #space separated

print (
	(@array == 0) ? ''						:
	(@array == 1) ? $array[0]				:
	(@array == 2) ? join(" en ", @array)	:
		join(", ", @array[0..($#array-1)], "en $array[-1]"));