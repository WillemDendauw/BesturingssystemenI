#Verwijder in een string alle whitespace die zich vooraan of achteraan bevindt

$string =~ s/^\s+//;
$string =~ s/\s+$//;