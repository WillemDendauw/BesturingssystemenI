#Construeer een test die nagaat of een string enkel (een willekeurig aantal) decimale getallen bevat, van
#elkaar gescheiden door whitespace. Maak de constructie opnieuw zo leesbaar mogelijk voor anderen.

$optional_sign		= '[-+]?';
$mandatory_digits	= '\d+';
$decimal_point		= '\.?';
$optional_digits	= '\d*';

$number = $optional_sign
		. $mandatory_digits
		. $decimal_point
		. $optional_digits;


if (/($number)/) {
	$found = $1;
}

@allnums = /$number/g;

unless (/^$number$/){ #controleren of er meer staat dan enkel een nummer
	print "need a number, just a number\n";
}

#combineren met de vorige vraag

m{
	^ \s *			#optional leading whitespace
	$number			#at least one number
	(?:				#begin optional cluster
		\s +		#must have some separator
		$number		#more the next one
	) *				#repeat at will
	\s * $			#optional trailing whitespace
}x

#dit is beter dan het volgende schrijven

/^\s*[-+]?\d+\.?\d*(?:\s+[-+]?\d+\.?\d*)*\s*/