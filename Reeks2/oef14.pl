#Hoe kun je vermijden dat je steeds twee perl opdrachten nodig hebt om eerst een substitutie met behulp van
#reguliere expressies uit te voeren, en vervolgens het resultaat te kopiëren in een specifieke variabele.

#in plaats van

$dst = $src;

$dst =~ s/this/that/;

#gebruik

($dst = $src) =~ s/this/that/;