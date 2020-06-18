#Je kan ook een scalaire variabele invullen met een referentie naar een scalaire variabele of een scalaire
#constante. Op welke verschillende manieren ? Hoe kun je via deze referentie de oorspronkelijke waarde
#aanspreken of wijzigen?

$scalar_ref = \$scalar; #get reference to named scalar

#te create a reference to a nanonymous sclara value (a value that isn't in a variable), assign to a dereferenced undefined variable

undef $anon_scalar_ref;
$$anon_scalar_ref = 15;

#this creates a refrence to a constant scalar:

$anon_scalar_ref = \15;

#use ${...} to dereference

print ${ $scalar_ref };
${ $scalar_ref } .= "string";