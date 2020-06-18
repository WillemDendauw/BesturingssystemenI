#Converteer een willekeurige string in uppercase of lowercase.

# Use the lc and uc functions or the \L and \U string escapes.

$big = uc($little);             # "bo peep" -> "BO PEEP"
$little = lc($big);             # "JOHN"    -> "john"
$big = "\U$little";             # "bo peep" -> "BO PEEP"
$little = "\L$big";             # "JOHN"    -> "john"
# To alter just one character, use the lcfirst and ucfirst functions or the \l and \u string escapes.

$big = "\u$little";             # "bo"      -> "Bo"
$little = "\l$big";             # "BoPeep"  -> "boPeep"


# Bespreking
# The functions and string escapes look different, but both do the same thing. You can set the case of either just the first character or the whole string. You can even do both at once to force uppercase (actually, titlecase; see later explanation) on initial characters and lowercase on the rest.

# $beast   = "dromedary";
# # capitalize various parts of $beast
# $capit   = ucfirst($beast);         # Dromedary
# $capit   = "\u\L$beast";            # (same)
# $capall  = uc($beast);              # DROMEDARY
# $capall  = "\U$beast";              # (same)
# $caprest = lcfirst(uc($beast));     # dROMEDARY
# $caprest = "\l\U$beast";            # (same)
# These capitalization-changing escapes are commonly used to make a string's case consistent:

# # titlecase each word's first character, lowercase the rest
# $text = "thIS is a loNG liNE";
# $text =~ s/(\w+)/\u\L$1/g;
# print $text;
# This Is A Long Line
# You can also use these for case-insensitive comparison:

# if (uc($a) eq uc($b)) { # or "\U$a" eq "\U$b"
#     print "a and b are the same\n";
# }
# Referenties
# The uc, lc, ucfirst, and lcfirst functions in perlfunc; \L, \U, \l, and \u string escapes in the "Quote and Quote-like Operators" section of perlop.