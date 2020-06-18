#Lees een mailboxbestand paragraaf per paragraaf in. Een nieuw mailbericht wordt gekenmerkt door een paragraaf waarin een lijn
#voorkomt met vooraan de string "From". Dergelijke headerparagrafen bevatten ook een "Subject:" lijn. Schrijf een volledig
#mailboxbestand uit op standaard uitvoer, gesorteerd op de inhoud van de "Subject:" lijn.

#!/usr/bin/perl
# bysub1 - simple sort by Subject
my(@msgs, @sub);
my $msgno = -1;
$/ = ''; #paragraph read mode
while(<>) {
	if(/^From/m){
		/^Subject:\s*(?:Re:\s*)*(.*)/mi;
		$sub[++$msgno] = lc($1) || '';
	}
	$msgs[$msgno] .= $_;
}
for my $i (sort { $sub[$a] cmp $sub[$b] || $a <=> $b } (0 .. $#msgs)) {
	print $msgs[$i];
}

#we'll sort on each field in the hash, by making an anonymous hash

#!/usr/bin/perl
# bysub3 - sort by subjct using hash records
use strict;

my @msgs = ( );
while (<>) {
	push @msgs, {
		SUBJECT 	=> /^Subject:\s*(?:Re:\s*)*(.*)/mi,
		NUMBER 		=> scalar @msgs, #het msgs nummer
		TEXT		=> '',
	} if /^From/m;
	$msgs[-1]{TEXT} .= $_;
}

for my $msg (sort {
		$a->{SUBJECT} cmp $b->{SUBJECT}
					||
		$a->{NUMBER} <=> $b->{NUMBER}
	} @msgs
	)
{
	print $msg->{TEXT};
}