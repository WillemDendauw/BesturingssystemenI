#Filter een array zodanig dat je alle elementen overhoudt die aan een specifieke voorwaarde voldoen.

#grep gebruiken om een condition te stellen en alleen degene die voldoen terug te geven

@matching = grep { test($_) } @LIST;

#kan ook met foreach

@matching = ( );
foreach(@LIST) {
	push(@matching, $_) if TEST($_);
}