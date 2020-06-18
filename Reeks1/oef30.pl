#Veronderstel dat je over twee lijsten beschikt, die elk geen duplikate waarden bevatten. Bereken de
#intersectie-, de unie-, en de verschil-lijsten: elementen die in beide lijsten, minstens in één van beide
#lijsten, of slechts in één van beide lijsten voorkomen.

@a = (1, 3, 5, 6, 7, 8);
@b = (2, 3, 5, 7, 9);

@union = @isect = @diff = ( );
%union = %isect = ( );
%count = ( );

#simpele oplossing voor union en intersectie

foreach $e (@A) { $union{$e} = 1 }

foreach $e (@B) {
	if ( $union{$e} ) { $isect{$e} = 1}
	$union{$e} = 1
}

@union = keys %union;
@isect = keys %isect;

#idiomatic

foreach $e (@A, @B) { $union{$e}++ && $isect{$e}++} #gaat pas naar het 2de deel van && indien de het eerste deel niet 0 was

@union = keys %union;
@isect = keys %isect;

#union, intersectie en symmetrisch verschil-lijsten
foreach $e (@a, @b) {$count{$e}++}

@union = keys %count;
foreach $e (keys %count){
	if($count{$e} == 2){
		push @isect, $e;
	}
	else {
		push @diff, $e;
	}
}