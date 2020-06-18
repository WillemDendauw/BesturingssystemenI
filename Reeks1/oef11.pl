#Hoe kun je binaire ("0b10110", ...), octale ("0755" ...), of hexadecimale ("0x55", ...) representaties van
#getallen omvormen in hun decimale vorm ? Perl kan immers enkel onmiddellijk met dergelijke representaties
#omgaan indien ze als constanten in de programmacode voorkomen. Indien de niet-decimale representaties worden
#ingelezen uit een bestand, of als waarden voorkomen van argumenten of environment variabelen, dan is expliciete
#conversie noodzakelijk.

$number = hex($hexadecimal)
$number = oct($hexadecimal)
$number = oct($octal)
$nubmer = oct($binary) #met oct kan je alles omvormen