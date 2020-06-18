#Tel het aantal lijnen in een bestand. Tel eveneens het aantal blokken (paragrafen) gescheiden door minimaal
#één lege lijn.

$count = 'wc -l < $file';
die "wc failed: $?" if $?;
chomp($count);

open(FILE, "<", $file) or die "can't open $file: $!";
$count++ while <FILE>

open(FILE, "<", $file) or die "can't open $file: $!";
for($count=0;<FILE>; $count++) { };

#paragrafen tellen

$/ = "";
open(FILE,"<", $file) or die "can't open $file: $!";
1 while <FILE>
$para_count = $.;