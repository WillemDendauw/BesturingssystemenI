#Soms is het noodzakelijk om niet de eerste, maar de Nde deelstring te vinden die aan een reguliere expressie
#voldoet. Filter bijvoorbeeld achtereenvolgens de woorden die voor het derde optreden en het laatste optreden
#van het woord "fish" staan in de string:

#			One fish two fish red fish blue fish


$want = 3;
$count = 0;
while(/(\w+)\s+fish\b/gi){
	if(++$count == $want){
		print "the third fish is a $1 one.\n";
		# warning: don't last out of this loop
	}
}

#of gebruik een repititon count en repeated pattern:

/(?:\w+\s+fish\s+){2}(\w+)\s+fish/i;



$pond  = 'One fish two fish red fish blue fish';

$color = ( $pond =~ /(\w+)\s+fish\b/gi )[2];  # just grab element 3

print "The third fish in the pond is $color.\n";



$count = 0;
$_ = 'One fish two fish red fish blue fish';
@evens = grep { $count++ % 2 == 0 } /(\w+)\s+fish\b/gi;
print "Even numbered fish are @evens.\n";



$count = 0;
s{
   \b               # makes next \w more efficient
   ( \w+ )          # this is what we'll be changing
   (
     \s+ fish \b
   )
}{
    if (++$count == 4) {
        "sushi" . $2;
    } else {
         $1   . $2;
    }
}gex;




#To express this same notion of finding the last match in a single pattern without /g, use the negative
#lookahead assertion (?!THING). When you want the last match of arbitrary pattern P, you find P followed
#by any amount of not P through the end of the string. The general construct is P(?!.*P)*, which can be
#broken up for legibility:

m{
    P               # find some pattern P
    (?!             # mustn't be able to find
        .*          # something
        P           # and P
    )
}xs

#That leaves us with this approach for selecting the last fish:

$pond = 'One fish two fish red fish blue fish swim here.';
if ($pond =~ m{
                \b  (  \w+) \s+ fish \b
                (?! .* \b fish \b )
            }six )
{
    print "Last fish is $1.\n";
} else {
    print "Failed!\n";
}
#Last fish is blue.