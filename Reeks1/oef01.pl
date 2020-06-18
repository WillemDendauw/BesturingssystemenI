#Hoe kun je een variabele instellen met een default waarde, enkel op voorwaarde dat die variabele
#op dat ogenblik geen waarde heeft ?

#$a wordt $b als $b true is, else $c
$a = $b || $c;

#$x wordt $y behalve indien $x al true is
$x ||=$y;

#indien 0, "0", "" geldige waarden zijn, gebruik je defined

#gebruik $b als $b gedefineerd is, anders $c
$a = defined($b) ? $b : $c;

# Bespreking
# The big difference between the two techniques (defined and ||) is what they test: definedness versus truth. Three defined values are still false in the world of Perl: 0, "0", and "". If your variable already held one of those, and you wanted to keep that value, a || wouldn't work. You'd have to use the more elaborate three-way test with defined instead. It's often convenient to arrange for your program to care about only true or false values, not defined or undefined ones.

# Rather than being restricted in its return values to a mere 1 or 0 as in most other languages, Perl's || operator has a much more interesting property: it returns its first operand (the lefthand side) if that operand is true; otherwise it returns its second operand. The && operator also returns the last evaluated expression, but is less often used for this property. These operators don't care whether their operands are strings, numbers, or references—any scalar will do. They just return the first one that makes the whole expression true or false. This doesn't affect the Boolean sense of the return value, but it does make the operators' return values more useful.

# This property lets you provide a default value to a variable, function, or longer expression in case the first part doesn't pan out. Here's an example of ||, which would set $foo to be the contents of either $bar or, if $bar were false, "DEFAULT VALUE":

# $foo = $bar || "DEFAULT VALUE";
# Here's another example, which sets $dir to be either the first argument to the program or "/tmp" if no argument were given.

# $dir = shift(@ARGV) || "/tmp";
# We can do this without altering @ARGV:

# $dir = $ARGV[0] || "/tmp";
# If 0 is a valid value for $ARGV[0], we can't use ||, because it evaluates as false even though it's a value we want to accept. We must resort to Perl's only ternary operator, the ?: ("hook colon," or just "hook"):

# $dir = defined($ARGV[0]) ? shift(@ARGV) : "/tmp";
# We can also write this as follows, although with slightly different semantics:

# $dir = @ARGV ? $ARGV[0] : "/tmp";
# This checks the number of elements in @ARGV, because the first operand (here, @ARGV) is evaluated in scalar context. It's only false when there are 0 elements, in which case we use "/tmp". In all other cases (when the user gives an argument), we use the first argument.

# The following line increments a value in %count, using as the key either $shell or, if $shell is false, "/bin/sh".

# $count{ $shell || "/bin/sh" }++;
# You may chain several alternatives together as we have in the following example. The first expression that returns a true value will be used.

# # find the user name on Unix systems
# $user = $ENV{USER}
#      || $ENV{LOGNAME}
#      || getlogin( )
#      || (getpwuid($<))[0]
#      || "Unknown uid number $<";
# The && operator works analogously: it returns its first operand if that operand is false; otherwise, it returns the second one. Because there aren't as many interesting false values as there are true ones, this property isn't used much.

# The ||= assignment operator looks odd, but it works exactly like the other binary assignment operators. For nearly all of Perl's binary operators, $VAR OP= VALUE means $VAR = $VAR OP VALUE; for example, $a += $b is the same as $a = $a + $b. So ||= is used to set a variable when that variable is itself still false. Since the || check is a simple Boolean one—testing for truth—it doesn't care about undefined values, even when warnings are enabled.

# Here's an example of ||= that sets $starting_point to "Greenwich" unless it is already set. Again, we assume $starting_point won't have the value 0 or "0", or that if it does, it's okay to change it.

# $starting_point ||= "Greenwich";
# You can't use or in place of || in assignments, because or's precedence is too low. $a = $b or $c is equivalent to ($a = $b) or $c. This will always assign $b to $a, which is not the behavior you want.

# Don't extend this curious use of || and ||= from scalars to arrays and hashes. It doesn't work, because the operators put their left operand into scalar context. Instead, you must do something like this:

# @a = @b unless @a;          # copy only if empty
# @a = @b ? @b : @c;          # assign @b if nonempty, else @c
# Referenties
# The || operator in perlop; the defined and exists functions in perlfunc.