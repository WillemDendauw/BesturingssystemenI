#Schrijf een programma dat alle tabs in a string converteert in een aantal spaties. Hierbij mag verondersteld
#worden dat alle tab stops zich op een veelvoud van 8 bevinden.


while($string=~ s/\t+/' ' x (length($&) * 8 - length($') % 8)/e){
	#lege loop gebruiken tot substitie faalt
}

# $& refereert naar de volledige voorgaande match