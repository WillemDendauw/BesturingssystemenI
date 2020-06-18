#Hoe kun je best bepalen hoeveel keer elke waarde in een tabel optreedt ?

%count = ( );
foreach $element (@array){
	$count{$element}++;
}