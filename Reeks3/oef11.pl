#Op welke manier kun je best een record datatype creëeren, bestaande uit diverse velden ? Geef aan hoe je een dergelijke
#structuur kunt initialiseren en gebruiken. Geef ondermeer aan hoe je de toegang via een specifiek veld kunt versnellen, en hoe
#je het eenvoudigst records kunt selecteren die aan een bepaald criterium moeten voldoen.

#Use a reference to an anonymous hash.

$record = {
	NAME 	=> "Jason",
	EMPNO 	=> 132,
	TITLE	=> "deputy peon",
	AGE		=> 23,
	SALARY	=> 37_000,
	PALS	=> [ "Norbert", "Rhys", "Phineas" ],
};

printf "I am %s, and my pals are %s.\n",
	$record->{NAME},
	join(", ", @{$record->{PALS}});

#Just having one of these records isn't much fun—you'd like to build larger structures. For example, you might want to create
#a %byname hash that you could initialize and use this way:

#store record
$byname{ $record->{NAME}} = $record;

#later on, look up by NAME
if ($rp = $byname{"Aron"}) { #false if missing
	printf "Aron is employee %d.\n", $rp->{EMPNO};
}

#give jason a new pal
push @{$byname{"Jason"}->{PALS}}, "theodore";
printf "Jason now has %d pals\n", scalar @{$byname{"Jason"}->{PALS}};

#the each iterator using to loop through it in an arbitrary order:

while(($name,$record) = each %byname) {
	printf "%s is employee number %d\n", $name, $record->{EMPNO};
}

#looking up emplyees by employeenumber:

$employees[ $record->{EMPNO} ] = $record;

if($rp = $employees[132]){
	printf "employee number 132 is %s\n", $rp->{NAME};
}

#updating salary:

$byname{"Jason"}->{SALARY} *= 1.035;

@peons = grep { $_->{TITLE} =~ /peon/i } @employees;
@tsevens = grep { $_->{AGE} == 27 } @employees;

#how to print all records in a particular order, say by age:

foreach $rp (sort { $a->{AGE} <=> $b->{AGE} } values %byname){
	printf "%s is age %d.\n", $rp->{NAME}, $rp->{AGE};
	printf "%s is employee number %d.\n", @$rp{"NAME","EMPNO"};
}

#another view by age:

push @{ $byage[ $record->{AGE} ] }, $record;

for ($age = 0; $age <= $#byage; $age++){
	next unless $byage[$age];
	print "Age $age: ";
	foreach $rp (@{byage[$age]}){
		print $rp->{NAME}, " ";
	}
	print "\n";
}

#map gebruiken

for ($age = 0; $age <= $#byage; $age++){
	next unless $byage[$age];
	printf "Age %d: %s\n", $age,
		join(", ", map { $_->{NAME}} @{$byage[$age]});
}