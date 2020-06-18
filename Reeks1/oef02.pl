#Hoe kun je de inhoud van twee of meer variabelen cyclisch omwisselen,
#zonder een intermediaire variabele te gebruiken ?.

($var1,$var2) = ($var2,$var1);

# Bespreking
# Most programming languages require an intermediate step when swapping two variables' values:

# $temp    = $a;
# $a       = $b;
# $b       = $temp;
# Not so in Perl. It tracks both sides of the assignment, guaranteeing that you don't accidentally clobber any of your values. This eliminates the temporary variable:

# $a       = "alpha";
# $b       = "omega";
# ($a, $b) = ($b, $a);        # the first shall be last -- and versa vice
# You can even exchange more than two variables at once:

# ($alpha, $beta, $production) = qw(January March August);
# # move beta       to alpha,
# # move production to beta,
# # move alpha      to production
# ($alpha, $beta, $production) = ($beta, $production, $alpha);
# When this code finishes, $alpha, $beta, and $production have the values "March", "August", and "January".

# Referenties
# The section on "List value constructors" in perldata.