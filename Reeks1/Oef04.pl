# Bepaal de inverse van een willekeurige, uit woorden samengestelde string:
# enerzijds door de individuele karakters van elk woord in omgekeerde zin af te lopen (om bijvoorbeeld palindromen te herkennen),
# anderzijds door de woorden in omgekeerde zin af te lopen, maar de volgorde van de karakters per woord te behouden.

# Use the reverse function in scalar context for flipping characters:

$revchars = reverse($string);
# To flip words, use reverse in list context with split and join:

$revwords = join(" ", reverse split(" ", $string));

# Bespreking
# The reverse function is two different functions in one. Called in scalar context, it joins together its arguments and returns that string in reverse order. Called in list context, it returns its arguments in the opposite order. When using reverse for its character-flipping behavior, use scalar to force scalar context unless it's entirely obvious.

# $gnirts   = reverse($string);       # reverse letters in $string

# @sdrow    = reverse(@words);        # reverse elements in @words

# $confused = reverse(@words);        # reverse letters in join("", @words)
# Here's an example of reversing words in a string. Using a single space, " ", as the pattern to split is a special case. It causes split to use contiguous whitespace as the separator and also discard leading null fields, just like awk. Normally, split discards only trailing null fields.

# # reverse word order
# $string = 'Yoda said, "can you see this?"';
# @allwords    = split(" ", $string);
# $revwords    = join(" ", reverse @allwords);
# print $revwords, "\n";
# this?" see you "can said, Yoda
# We could remove the temporary array @allwords and do it on one line:

# $revwords = join(" ", reverse split(" ", $string));
# Multiple whitespace in $string becomes a single space in $revwords. If you want to preserve whitespace, use this:

# $revwords = join("", reverse split(/(\s+)/, $string));
# One use of reverse is to test whether a word is a palindrome (a word that reads the same backward or forward):

# $word = "reviver";
# $is_palindrome = ($word eq reverse($word));
# We can turn this into a one-liner that finds big palindromes in /usr/dict/words:

# % perl -nle 'print if $_ eq reverse && length > 5' /usr/dict/words
# deedeed
# degged
# deified
# denned
# hallah
# kakkak
# murdrum
# redder
# repaper
# retter
# reviver
# rotator
# sooloos
# tebbet
# terret
# tut-tut
# Referenties
# The split, reverse, and scalar functions in perlfunc.