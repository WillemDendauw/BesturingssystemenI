#Indien een functie (stat bijvoorbeeld) een lijst met meerdere elementen als terugkeerwaarde heeft,
#hoe kun je dan slechts met een beperkt aantal van deze elementen expliciet rekening houden,
#en de andere elementen negeren ?

($a, undef, $c) = func( );
#of
($a, $c) = (func( ))[0,2];