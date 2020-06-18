#Hoe kan in een string, die bijvoorbeeld het resultaat is van gebruikersinput of van inlezen vanuit een
#bestand, een deelstring voorafgegaan door een $-teken vervangen worden door de inhoud van de variabele
#met die naam ?

$text =~ s/\$(\w+)/${$1}/g;

#/ee gebruiken als het lexical (my) varables zijn

$text =~ s/(\$\w+)/$1/gee;

# expand variables in $text, but put an error message in
# if the variable isn't defined
$text =~ s{
     \$                         # find a literal dollar sign
    (\w+)                       # find a "word" and store it in $1
}{
    if (defined ${$1}) {
        ${$1};                    # expand global variables only
    } else {
        "[NO VARIABLE: \$$1]";  # error msg
    }
}egx