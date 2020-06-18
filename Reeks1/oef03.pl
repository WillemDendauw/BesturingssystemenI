#Geef de (numerieke) ascii-waarde weer van een willekeurig karakter.
#Geef de karakterrepresentatie weer van een willekeurige numerieke ascii-waarde.
# Use ord to convert a character to a number, or use chr to convert a number to its corresponding character:

$num  = ord($char);
$char = chr($num);
# The %c format used in printf and sprintf also converts a number to a character:

$char = sprintf("%c", $num);                # slower than chr($num)
printf("Number %d is character %c\n", $num, $num);
# Number 101 is character e

# Bespreking
# Perl doesn't treat characters and numbers interchangeably; it treats strings and numbers interchangeably. That means you can't just assign characters and numbers back and forth. Perl provides Pascal's chr and ord to convert between a character and its corresponding ordinal value:

# $value     = ord("e");    # now 101
# $character = chr(101);    # now "e"
# If you already have a character, it's really represented as a string of length one, so just print it out directly using print or the %s format in printf and sprintf. The %c format forces printf or sprintf to convert a number into a character; it's not used for printing a character that's already in character format (that is, a string).

# printf("Number %d is character %c\n", 101, 101);
# Referenties
# The chr, ord, printf, and sprintf functions in perlfunc.