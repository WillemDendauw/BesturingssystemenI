#Hoe kun je op een string meerdere reguliere expressies toepassen, waarbij elke volgende reguliere expressie
#pas begint te werken na de deelstring die aan de vorige reguliere expressie voldoet?

 #combinatie van /g en /c match modifiers, de \G pattern anchor en de pos functie

 #/g zorgt ervoor dat de positie van de match wordt opgeslagen, de volgen match met /g begint dan daar weer te zoeken

 while (/(\d+)/g) {
    print "Found number $1\n";
}

#\G betekent op het einde van een vorige match
$n = "   49 here";
$n =~ s/\G /0/g;
print $n;
#00049 here

#indien match fails, positie is gereset, als je dat niet wil gebruik /c

$_ = "The year 1752 lost 10 days on the 3rd of September";

while (/(\d+)/gc) {
    print "Found number $1\n";
}
# the /c above left pos at end of final match

if (/\G(\S+)/g) {
    print "Found $1 right after the last number.\n";
}

#Found number 1752
#Found number 10
#Found number 3
#Found rd after the last number.

