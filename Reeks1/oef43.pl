#Wijzig een invoerbestand, zonder, zoals in vraag 42, gebruik te maken van een intermediair hulpbestand,
#maar met behulp van de -i optie op de opdrachtlijn, of door toekenning van de speciale variabele $^I.

#op commandline

% perl -i.orig -p -e 'FILTER COMMAND' file1 file2 file3 ...

while (<>) {
	if ($ARGV ne $oldargv){
		rename($ARGV, $ARGV . ".orig");
		open(ARGVOUT, ">", $ARGV);
		select(ARGVOUT);
		$oldargv = $ARGV;
	}
	s/DATA/localtime/e;
}
continue{
	print;
}
select(STDOUT);

#===>

%perl -pi.orig -e 's/DATE/localtime/e'