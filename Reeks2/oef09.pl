#Verwerk een bestand veld per veld. Je mag veronderstellen dat de velddelimiter kan omschreven worden met
#behulp van een reguliere expressie.

@fields = split(/pattern/, $record);

split(/([+-])/, "3+5-2");

@fields = split(/:/, $record);