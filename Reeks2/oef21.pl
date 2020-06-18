#Lees opnieuw een tekstbestand paragraaf per paragraaf in. Filter met behulp van een reguliere expressie alle
#tekst die zich tussen twee specifieke kodes, bijvoorbeeld START en END, die zich aan het begin van een lijn
#bevinden. Deze kodes kunnen meerdere keren in elke paragraaf optreden.

$/ = ''; #paragraph mode
while(<ARGV>){
	while(/^START(.*?)^END/gsm){
		print "chunk $. in $ARGV has <<$1>>\n"
	}
}