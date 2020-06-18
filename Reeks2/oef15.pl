#De open functie van perl kan niet rechtstreeks omgaan met bestandsnamen waarin de tilde wildcard (~)
#gebruikt wordt om naar de home directory te refereren. Hoe kan dit omzeild worden?

#blog functie gebruiken

open(FH, glob("~joebob/somefile")) || die "Couldn't open file: $!";

#of filename expanden

$filename =~ s{ ^ ~ ( [^/]* ) }
				{ $1
					? (getpwnam($1))[7]
					: ( $ENV{HOME} || $ENV{LOGDIR}
						|| (getpwuid($<))[7]
						)
				}ex;