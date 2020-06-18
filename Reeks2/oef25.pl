#Vul in een string, louter met behulp van een reguliere expressie, alle substrings, die er als DNS-namen
#uitzien, aan met hun IP-adres (tussen vierkante haakjes), op voorwaarde dat de gethostbyname functie met de
#DNS-naam als argument een resultaat oplevert. Dit resultaat kan met behulp van de inet_ntoa functie in het
#traditionele IP-adresformaat geconverteerd worden. Beide functies vereisen vermelding van de instructie

#use Socket;

#vooraan het programma. Maak de reguliere expressie zo leesbaar mogelijk voor anderen, door het gebruik van
#extra whitespace en commentaar.

#!/usr/bin/perl -perl
#resname - change all "foo.bar.com" style names in the input stream
#into "foo.bar.com [204.148.40.9]" (or whatever) instead

use Socket;					#load inet_addr
s{							
	(						#capture the hostname in $1
		(?:					#these parentesies for grouping only
			(?! [-_] )		#lookahead for neither underscore nor dash
				[\w-] +		#hostname component
				\.			#and the domain dot
			) +				#repeat that whole thing a few times
		[A-Za-z]			#next must be a letter
		[\w-] +				#trailing domain part
	)						#end of $1 capture
}{							#replace with
	"$1 " .					#original bit and space
			( ($addr = gethostbyname($1))		#if we get an addr
			? "[" . inet_ntoa($addr) . "]"		# formateer
			: "[????]"							# else mark 
			)
}gex;	# /g for global
		# /e for execute
		# /x for formatting