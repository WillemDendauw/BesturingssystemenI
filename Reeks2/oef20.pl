#Lees een tekstbestand paragraaf per paragraaf in. Verpak de eerste lijn in elke paragraaf in <H1>...</H1>
#HTML-tags, op voorwaarde dat die lijn begint met een string van volgende gedaante: "Chapter xx: ..." .
#Gebruik hierbij een reguliere expressie met betrekking tot een string die meerdere lijnen omvat. De metatekens
#. , ^ , en $ vergen dan ook een bijzondere behandeling.

# /s laat . toe om te matchen met een newline
# /m laat toe dat ^ en $ matchen vlak voor en vlak achter een newline
# niet mutueel exclusief

#!/usr/bin/perl
#killtags - very bad html tag killer

undef $/;			#volledige bestand inlezen
while(<>) {
	s/<.?>//gs;
	print;
}

#!/usr/bin/perl
# headerfy: change certain chapter headers to html

$/ = '';
while ( <> ){			#fetch paragraph
	s{
		\A 				#start of record
		(				#capture $1
			Chapter 	#text
 			\s+			#whitespace
			\d+			#nummer
			\s*			#opt whitespace
			:			#dubbele punt
			.*			#alles tot een newline
		)
	}{<H1>$1</H1>}gx;
	print;
}