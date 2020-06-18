#Stel een nieuwe hash samen op basis van twee bestaande hashes. Je hoeft geen rekening te houden met indices
#die in beide originele hashes zouden voorkomen.

%merged = (%a, %b);

#om memory te besparen, loopen

%merged = ( );
while( ($k,$v) = each(%a)) {
	$merged{$k} = $v;
}
while( ($k,$v) = each(%b)) {
	$merged{$k} = $v;
}