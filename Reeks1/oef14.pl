#Bepaal datum and tijd van een tijdstip in het verleden of de toekomst

$difference = 1234567;
print "verschil in seconden=",$difference,"\n";
$now = time();
print "nu=",scalar localtime($now),"\n";
$when = $now + $difference;
print "when=",scalar localtime($when),"\n";
$then = $now - $difference;
print "then=",scalar localtime($then),"\n";