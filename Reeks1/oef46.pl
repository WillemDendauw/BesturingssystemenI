#Schrijf één of meerdere lijnen, met specifieke lijnnummer(s), uit van een invoerbestand.

$. = 0;
do { $line = <HANDLE> } until $. == $desired_line_number || eof;

#of in array zetten

@lines = <HANDLE>
$line = $lines[$desired_line_number]