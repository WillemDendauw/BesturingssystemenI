#In perl is het niet mogelijk om als recorddelimiter (in de $/ variabele) een reguliere expressie te gebruiken.
#Hoe kun je dit toch simuleren ? Dit kan soms het parsen van complex geformatteerde inputbestanden aanzienlijk
#vereenvoudigen.

undef $/
@chunks = split(/pattern/,<FILEHANDLE>);