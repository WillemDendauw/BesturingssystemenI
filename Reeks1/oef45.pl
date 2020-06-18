#Verwerk een bestand in omgekeerde zin:
#hetzij lijn per lijn,
#hetzij paragraaf per paragraaf.

@lines = <FILE>
while ($line = pop @lines) {
	#do something with $line
}

@lines = reverse <FILE>;
foreach $line (@lines) {
	#doe something with $line
}

#paragraaf

{
	local $/ ="";
	@paragraphs = reverse <FILE>;
}

foreach $paragraph (@paragraphs){
	#dosomething
}