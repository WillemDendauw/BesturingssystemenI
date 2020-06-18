#Bepaal dag, maand en jaar van de datum vandaag. Bepaal ook het nummer van de week in het jaar.

#($seconds, $minutes, $hours, $day_of_month, $month, $year, $wday, $yday, $isdst) = localtime($time);

($day_of_month, $month, $year) = (localtime)[3,4,5];
print "dag=$day_of_month\n";
print "maand=$month\n";
print "jaar=$year\n";

print scalar localtime;