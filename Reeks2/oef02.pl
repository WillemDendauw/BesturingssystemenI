#Gebruik een reguliere expressie om een string in woorden te parsen.

/\S+\; #as many non-whitespaces as possible
/[A-Za-z'-]+/;

/\b([A-Za-z]+)\b/; #usually best
/\s([A-Za-z]+)\s/; #fails at ends or w/ punctuation