#Hoe kun je slechts een deel van een string wijzigen ? Dit kan ondermeer interessant zijn om specifieke
#velden te wijzigen van records met vaste veldgrenzen.

#via substr

$value = substr($string, $offset, $count);
$value = substr($string, $offset);

substr($string, $offset, $count) = $newstring;
substr($string, $offset, $count, $newstring);   #hetzelfde als hierboven
substr($string, $offset) = $newtail;

$string = "this is what you have";

$first 	= substr($string,0,1); 	#T
$start 	= substr($string,5,2); 	#is
$rest 	= substr($string,13); 	#you have
$last 	= substr($string,-1);	#e
$end 	= substr($string,-4);	#have

#in combinatie met patternmatching

substr($string,0,5) =~ s/is/at/g

$a = "make a hat";
(substr($a,0,1), substr($a,-1)) = 
(substr($a,-1),  substr($a,0,1));
print $a;