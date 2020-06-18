#Hoe kun je array's met veel niet-benutte elementen, zogenaamde sparse array's,
#implementeren zonder geheugenoverhead ?

#hashes gebruiken

$#foo = 5;
@bar = ( (undef) x 5);

printf "foo element 3 is%s defined\n",defined $foo[3] ? "": "n't";
printf "foo element 3 does%s exist\n",exists $foo[3] ? "": "n't";
printf "bar element 3 is%s defined\n",defined $bar[3] ? "": "n't";
printf "bar element 3 does%s exist\n",exists $bar[3] ? "": "n't";


$real_array[ 1000000 ] = 1; #kost 4+ MB

$fake_array{ 1000000 } = 1; #kost 28bytes

#bij een array doe je dit

foreach $element ( @real_array) {
	#doe iets met $element
}

#of dit als je volgorde wil handhaven

foreach $idx ( 0 .. $#real_array){
	#doe iets met $real_array[$idx]
}

#om bij hashes in indexorder te werken, moet je het volgende doen

foreach $element ( @fake_array{ sort {$a <=> $b} keys %fake_array} ){
	#doe iets met $element
}

#of om met ascending indexen te werken

foreach $idx ( sort {$a <=> $b} keys %fake_array) {
	 #doe iets met $fake_array{$idx};
}
 
#of als volgorde er niet toe doet

foreach $element ( values %fake_array){
	#doe iets met $element
}

#of

foreach $idx ( keys %fake_array){
	#doe iets met $fake_array{$idx}
}





#@X = split " ",<>;
#%X = map {$_,undef} @X;

#print join " ", sort keys %X;

#@Y = split " ",<>;

#delete @X{@Y};

#print join " ", sort keys %X;
#print "\n";

#__DATA__
#drie vier vijf drie acht negen twee drie twaalf negen zeven vijf een drie twaalf twee
#een twee drie vier