#Gebruik de range operatoren, .. en ..., om van een bestand, dat je nu opnieuw lijn per lijn inleest, alle
#tekst te filteren die zich tussen twee specifieke kodes bevindt. Deze kodes kunnen meerdere keren in het
#bestand optreden. Pas deze methode eveneens toe om lijnen met lijnnummers in een specifiek interval te filteren.

#de .. operator test de rechtse operand of dezelfde iteratie als de linker operand

while(<>) {
	if(/BEGIN PATTERN/ .. /END PATTERN/ ){
		#line falls between begin and end in the text, inclusive
	}
}

while(<>){
	if(FIRST_LINE_NUM .. LAST_LINE_NUM) {
		#operate only between first and last line, inclusive
	}
}

# ... controleert de rechtse operand slechts op de volgende lijn

while(<>){
	if(/BEGIN PATTERN/ ... /END PATTERN/){
		#line is between begin and end on different lines
	}
}

while(<>){
	if(FIRST_LINE_NUM ... LAST_LINE_NUM){
		#operate only between first and last line, not inclusive
	}
}

