# Verwerk eerst de inleidende demonstratie (ook beschikbaar op Ufora). Open dit PowerPoint bestand in de Show Presenter View van
# Slide Show. Volg de aanwijzingen erin strikt, vooraleer je aan de opgave begint. De bestanden s11.pdf, s14.pdf, s17.pdf, s21.pdf,
# s24.pdf, s27.pdf, s31.pdf, s34.pdf, s37.pdf, s42.pdf, s46.pdf, s51.pdf, s57.pdf, s61.pdf en s66.pdf bevatten elk een figuur die
# een doolhof voorstelt, met rechtlijnige wanden. Achterhaal telkens de structuur van het doolhof door het bestand met behulp van
# reguliere expressies te parsen. Produceer vervolgens een eenvoudige representatie van het doolhof, bijvoorbeeld zoals in s11.txt.
# Zorg ervoor dat hetzelfde script ook de bestanden c11.pdf, c14.pdf, c17.pdf, c21.pdf, c24.pdf, c27.pdf, c31.pdf, c34.pdf, c37.pdf,
# c41.pdf, c46.pdf, c50.pdf, c56.pdf, c61.pdf en c65.pdf kan interpreteren. In deze figuren worden de wanden voorgesteld door
# gekromde lijnen.

# ……
# De pdf bestanden tonen een doolhof, 
# met een rechthoekig rooster van cellen.
# Sommige doorgangen tussen naburige cellen blijven open,
# terwijl andere doorgangen geblokkeerd zijn door rechtlijnige wanden.
# Er zijn ook wanden voor op twee na  (de in- en uitgang) alle cellen aan de vier randen van het rooster.

# Het is in deze oefening louter de bedoeling om de locatie van de wanden,
# zowel die tussen naburige cellen, als die aan de randen van het rooster,
# uit het pdf bestand te parsen,
# en een perl datastructuur te implementeren,
# die voor elke mogelijke rand of overgang aanduidt,
# of er al dan niet een wand is.

# Een tweedimensionale tabel,
# in perl een array van pointers naar anonieme arrays,
# zal de job kunnen klaren.
# Over de dimensies van die tweedimensionale array
# zullen we onmiddellijk nog wel hebben.

# Eens je de informatie van het pdf bestand,
# geconverteerd hebt in de tweedimensionale array,
# moet je aantonen dat dit correct uitgevoerd is.

# Doe dit in deze oefening door een elementaire representatie
# van het doolhof op het uitvoerkanaal uit te printen, zoals
# op de rechterfractie van de slide getoond.
# Het script moet één enkel argument aanvaarden:
# de naam van het pdf bestand.

# Gebruik bij de weergave op console:
# + tekens om de hoeken van elke cel voor te stellen,
# | tekens voor vertikale wanden, tussen naburige cellen op dezelfde rij,
# of aan de linker- of rechter rand van het rooster,
# en - tekens voor horizontale wanden, tussen naburige cellen in dezelfde kolom,
# of aan de boven- of onderrand van het rooster.
# ……


# ……
# Alhoewel je dat misschien niet onmiddellijk zou verwachten,
# bestaat een pdf bestand uit lijnen tekst.
# Dat wordt meteen duidelijk als je het bestand opent in een editor.

# De diverse lijnen tekst coderen op een of andere manier
# de informatie die door een pdf reader, zoals acrobat,
# als figuur wordt weergegeven.

# In deze oefening zijn we enkel geïnteresseerd in de tekstlijnen
# die wanden als rechte lijnen weergeven.

# Het pietsen van deze informatie uit een bestand
# is een vervelende bedoening,
# mocht je geen elementaire kennis hebben van reguliere expressies,
# en/of niet weten hoe je daarmee in perl moet omgaan.
# Telkens je in perl met reguliere expressies wil werken,
# moet je jezelf vier opeenvolgende vragen stellen:

# 1. lijn of slurp mode, met andere woorden undef $/ niet of wel ?
# Komen we onmiddellijk op terug.

# 2. split gebruiken om met reguliere expressies delimiters te beschrijven ?
# of reguliere expressies  via de m (matching) operator, de waardevolle informatie eruit laten pietsen ?
# Hier zondermeer de tweede optie.

# 3. progressief of traditioneel  (al dan niet met de g modifier) ?
# Het antwoord hierop is nauw verbonden met het antwoord op vraag 1.
# Komen we bijgevolg ook op terug.

# 4. in scalaire of lijstcontext ? 
# Maakt niet veel uit.

# Behalve de locatie van de wanden, 
# is nog andere informatie gecodeerd in het bestand:
# de header en footer van de figuur,
# de groene en rode pijlen.
# Dit alles willen we compleet negeren.
# Hier blijkt dit gemakkelijk te kunnen door volgende regels toe te passen:

# 1. In het bestand zullen er meerdere  (concreet telkens twee) tekstlijnen staan
# die eindigen op " w", een spatie gevolgd door de kleine letter w.
# Alles vooraan het bestand tot en met de laatste dergelijke lijn moet genegeerd worden.

# 2. In het bestand staat er precies één tekstlijn die de string endstream bevat.
# Alles vanaf deze lijn tot aan het einde moet genegeerd worden.
# ……


# ……
# In de resterende fractie van het bestand, niet gearceerd op de slide,
# wordt elke wand gecodeerd door twee opeenvolgende lijnen,
# hierna tekstlijnkoppel genoemd,
# een eerste lijn eindigend op " m", een spatie gevolgd door de kleine letter m.
# de daaropvolgende lijn eindigend op " l", een spatie gevolgd door de kleine letter l.
# De twee getallen op deze tekstlijnen stellen telkens de (x,y) coördinaat voor
# van de lijnuiteinden van de wand.

# x duidt de afstand aan, in pixels, naar rechts toe,
# y duidt de afstand aan, in pixels, naar boven toe, 
# telkens ten opzichte van de linkeronderhoek van de figuur.

# Zijn de eerste getallen van de m- en l-tekstlijnen gelijk,
# dan wordt een vertikale  wand voorgesteld.
# ……


# ……
# Zijn de tweede getallen van de m- en l-tekstlijnen gelijk,
# dan wordt een horizontale wand voorgesteld.
# Het is het een of het ander. Schuine lijnen zijn er niet.

# Hoe nu vragen 1. en 3. van de vorige slide beantwoorden ?
# Maakt niet uit. De code zal enigszins verschillen, maar niet veel.
# Probeer beide alternatieven uit.

# Indien je kiest voor de lijn mode,
# dan moet je eerst, zonder de g modifier, dus traditioneel,
# matchen  op een lijn eindigend op m,
# De twee cijfers van de lijn via tagging eruit pietsen, en bewaren,
# en vervolgens uit de daaropvolgende lijn, indien die eindigt op l,
# opnieuw de twee cijfers, zonder de g modifier, via tagging eruit pietsen.

# Indien je kiest voor de slurp mode,
# dan moet je een reguliere expressie gebruiken over twee tekstlijnen heen,
# en progressief, met de g modifier, de volledige string blijven verwerken.
# Je kunt dan wel telkens ineens de vier relevante cijfers
# van elk tekstlijnkoppel via tagging eruit pietsen.

# Hoe dan ook beschik je over de twee coördinaten (x1,y1) en (x2,y2) van elke lijn in de figuur,
# die één of meerdere opeenvolgende wanden, in elkaars verlengde dan wel, voorstelt.
# Eén enkele lijn kan dus wel degelijk de randen of overgangen tussen meerdere buurcelkoppels voorstellen.
# Kleine complicatie, met een for lus op te vangen.
# ……


# ……
# En nu ?
# Een tweedimensionale array om bij te houden of de randen van elke cel
# open of door een wand gesloten () zijn.

# Bijvoorbeeld een eerste niveau van arrayindexering in de x-richting,
# en een tweede niveau van arrayindexering in de y-richting.
# Of omgekeerd. Doet er niet toe. Is maar een conventie.

# Beide niveau's van indexering vereisen uiteraard integers, 
# liefst zo klein mogelijk.
# We verwachten in beide dimensies één index meer dan het aantal cellen in elke rij/kolom.

# Groot probleem.
# Terwijl we het bestand aan het verwerken zijn,
# beschikken we niet over rij- of kolomnummers,
# maar enkel over x- en y-waarden uitgedrukt in pixels.

# Oplossing: zullen het bestand tweemaal moeten verwerken.

# een eerste keer, louter om het verband te weten te komen
# tussen de x- en y-waarden uitgedrukt in pixels,
# en een corresponderend  rij/kolom-nummer.

# Verwerk elk tekstlijnkoppel.
# Telkens levert dat een x en twee y's, of twee x'en en een y op,
# afhankelijk of je een verticale of horizontale wand hebt.
# Als je een nieuwe x of y tegenkomt,
# dan weet je nog aan geen kanten met welk rij/kolom-nummer die zal overeenkomen.
# Je moet enkel bijhouden welke diverse x'en en y's je allemaal hebt tegengekomen.
# Verzamelingen. Het interesseert je niet hoeveel keer je een specifieke x of y bent tegengekomen.
# Je kan hiervoor twee array's of twee hashes gebruiken, voor elke dimensie één.
# Moet er toch geen tekeningske bijmaken, voor welke optie je best kiest.
# Doe wat je wilt, maar draag de gevolgen van een foutieve keuze.
# Ook dan echter zou je tot een correct resultaat moeten kunnen komen.

# Eens je alle tekstlijnkoppels hebt verwerkt,
# kan je de beide verzamelingen, onafhankelijk van elkaar, op pixelwaarde sorteren.
# De diverse x'en en y's zullen blijken nagenoeg equidistant uit elkaar te liggen.
# De kolommen en rijen van het rooster worden immers nagenoeg even breed voorgesteld.
# Je moet met deze waarheid als een koe echter geenszins rekening houden.
# Er zal immers in elke rij of kolom wel minstens één wand zijn.

# Pas na sortering kan je de opeenvolgende x- en y-waarden mappen op opeenvolgende rij/kolom-nummers.
# Hou die mapping ook bij.
# Moet er toch opnieuw geen tekeningske bijmaken, hoe je dat het best doet.
# ……


# ……
# nu je over het mappingmechanisme beschikt,
# verwerk je het bestand een tweede keer.

# Verwerk elk tekstlijnkoppel.
# Telkens levert dat opnieuw een x en twee y's, of twee x'en en een y op.
# Dankzij het mappingsmechanisme weet je nu met welke rij/kolom een x of y overeenkomt.
# Voer de conversie van pixels naar rij/kolom-nummers uit,
# vooraleer je de tweedimensionale array bijwerkt.

# Ik heb je wel wijsgemaakt dat het de bedoeling is om de wandinformatie op te slaan
# in een tweedimensionale array,
# waarvan de laatste indices in elke dimensie
# precies gelijk zijn aan het aantal cellen in elke rij/kolom.

# Zou daar wel enigszins op willen terugkomen.
# Ik zou voorstellen om de gemapte rij/kolom-nummers te verdubbelen,
# zoals met rood aangeduid op de slide,
# en de laatste indices in elke dimensie bijgevolg dubbel zo groot te maken.

# In een dergelijke tweedimensionale array @T,
# die in elke dimensie (bijna) dubbel zoveel elementen heeft,
# kan je niet alleen informatie kwijt over de wanden,
# maar ook over alle cellen, mocht je dat kunnen gebruiken,
# en zelfs informatie over alle hoekpunten van cellen, mocht je dat kunnen gebruiken.

# De noodzaak tot informatie bijhouden over de hoekpunten is misschien minder waarschijnlijk,
# maar die over cellen is er zeker wel.
# Bijvoorbeeld indien we een pad doorheen het doolhof zouden willen construeren.
# Dat is nu wel niet gevraagd,
# maar toch een goede gelegenheid om aan te tonen
# dat één datastructuur zonder moeite
# diverse types informatie van informatie kan bevatten.

# Hier, indien de tweedimensionale tabel geïndexeerd wordt via $T[rij][kolom],
# dan bevat die $T[rij][kolom]:

# 1. indien zowel rij als kolom even is,
# informatie over een hoekpunt van de roostercellen,
# cfr. de kruisingen van de rode stippellijnen op de slide,

# 2. indien zowel rij als kolom oneven is,
# informatie over een cel,
# cfr. de kruisingen van de blauwe stippellijnen op de slide,

# 3. indien rij oneven is en kolom even,
# de informatie over de vertikale wand die de hoekpunten
# met coördinaten (rij-1,kolom) en (rij+1,kolom) verbindt,

# 4. indien rij even is en kolom oneven,
# de informatie over de horizontale wand die de hoekpunten
# met coördinaten (rij,kolom-1) en (rij,kolom+1) verbindt.

# Wat is de informatie die je als value aan het $T[rij][kolom] element moet geven ,
# in het bijzonder voor wanden (één  index even, de andere oneven) ?
# True of false zou al volstaan om aan te duiden dat de wand er is, of juist niet.
# Welke true value ?
# Maakt niet uit.
# Kies een true value die het je,
# eens @T volledig ingevuld,
# zo eenvoudig mogelijk maakt om 
# te bewijzen dat @T wel degelijk correct is ingevuld.

# Een uitprint op console, op basis van @T, moet immers
# precies hetzelfde beeld schetsen als het beeld in een pdf reader.

# Indien dit gelukt is……


# ……
# een kleine extra taak !

# De pdf bestanden met prefix c (curved) in plaats van prefix s (straight), 
# tonen eveneens een rechthoekig rooster van cellen.
# Nu zijn de doorgangen tussen naburige cellen 
# geblokkeerd door gekromde wanden.
# Ziet er heel wat mooier uit, zeker voor grote roosters (zoals c65.pdf)
# Er zijn ook wanden voor op twee na alle cellen aan de vier randen van het rooster.

# Pas jouw werkend perl programma nu zodanig aan,
# dat het ook dergelijke doolhofbestanden aankan,
# met gekromde wanden.
# Doel blijft hetzelfde.
# Eerst conversie in een tweedimensionale array @T,
# en vervolgens, enkel @T aansprekend,
# een elementaire representatie van het doolhof op het uitvoerkanaal produceren,
# zoals op de rechterfractie van de slide getoond.

# Het is niet de bedoeling dat je een tweede versie van het programma schrijft,
# één toepasbaar op rechte wanden, en één op gekromde wanden,
# maar dat het programma zelf detecteert welk type wanden er gebruikt wordt,
# en er dan navenant  op reageert.
# ……


# ……
# Inhoudelijk verschillen de twee types pdf bestanden nauwelijks:

# waar in een pdf met rechte wanden tekstlijnkoppels optreden, bestaande uit
# een eerste tekstlijn eindigend op " m", 
# een tweede tekstlijn eindigend op " l",
# telkens voorafgegaan door twee getallen die een (x,y) coördinaat voorstellen,

# bestaan in een pdf met gekromde wanden de tekstlijnkoppels uit
# opnieuw uit een eerste tekstlijn eindigend op " m",
# voorafgegaan door twee getallen die een (x,y) coördinaat voorstellen,
# en een tweede tekstlijn.
# Deze eindigt nu echter op " c",
# en wordt voorafgegaan door zes getallen die drie coördinaten voorstellen,

# De vier coördinaten , op de slide in rood of groen gearceerd,
# bepalen een bezierkromme van de derde graad,
# ter vervanging van de rechtlijnige wand, op de slide met een blauwe stippellijn voorgesteld.
# Als je meer wil weten over dergelijke bezierkrommen,
# verwijs ik je naar het keuzevak computergrafiek.

# De eerste en vierde coördinaat, rood gearceerd,
# bepalen de locatie van de beide uiteinden van de kromlijnige wand.
# Ten opzichte van de uiteinden van de corresponderende rechtlijnige wand,
# zijn de uiteinden van een kromlijnige wand,
# enkele pixels naar linksboven of rechtsonder verschoven.

# De tweede en derde coördinaat, groen gearceerd,
# bepalen de kromming van de bezierkrommen,
# en zijn in deze oefening van geen enkel belang.
#  ……


# ……
# Indien je nu, analoog als in een pdf met rechte wanden,
# een dergelijk tekstlijnkoppel verwerkt,
# dan komen er met elke potentiële rij of kolom,
# niet één enkele x of y, uitgedrukt in pixels, overeen,

# maar telkens twee verschillende waarden:
# x' en x", respectievelijk enkele pixels meer en minder dan een x voor een rechtlijnige wand,
# y' en y", opieuw enkele pixels meer en minder dan een y voor een rechtlijnige wand,

# Opnieuw zal je het pdf bestand tweemaal moeten verwerken.

# een eerste keer, louter om het verband te weten te komen
# tussen de x- en y-waarden uitgedrukt in pixels,
# en een corresponderend  rij/kolom-nummer.

# Na parsing bekom je twee verzamelingen,
# een voor de diverse x'en, en een voor de diverse y's.
# Deze verzamelingen zullen blijken twee keer zoveel elementen te bevatten,
# ten opzichte van de voorstelling met rechte wanden van hetzelfde doolhof.
# Je bekomt steeds koppels van twee pixelwaarden, die nauwelijks van elkaar verschillen.
# De diverse koppels liggen nagenoeg equidistant uit elkaar.

# Na sortering van beide verzamelingen, onafhankelijk van elkaar, op pixelwaarde,
# moet je nu niet elk element op opeenvolgende rij/kolom-nummers mappen,
# maar de twee dicht opeenvolgende elementen telkens op hetzelfde rij/kolom-nummer.
# Het aantal verschillende values zal hierdoor de helft bedragen van het aantal indices.
# ……


# ……
# Eens je over het mappingmechanisme beschikt,
# verwerk je het bestand een tweede keer.

# Hier zal je geen enkel verschil meer merken ten opzichte van 
# de verwerking van een pdf met rechte wanden.
# Het implementatieverschil zit louter in de mapping van pixels in rij/kolom-nummers.
# In codering is dan ook slechts een beperkte aanpassing vereist.

# Maandag 27 april wordt een oplossing gepubliceerd.


@OARG = @ARGV;
undef $/; 									# slurp mode
$_ = <>;									# bestand een eerste keer inlezen
s/.* w$//ms;								# elimineren niet-relevante gegevens
s/^endstream.*//ms;


#$curly = (s/^\d+(?:\.\d*)? \d+(?:\.\d*)? \d+(?:\.\d*)? \d+(?:\.\d*)? (\d+(?:\.\d*)? \d+(?:\.\d*)?) c$/\1 l/gsm ? 1 : 0 );
$f = $_;

while ( $f =~ /^(\d+)(?:\.\d*)? (\d+)(?:\.\d*)? m.(\d+)(?:\.\d*)? (\d+)(?:\.\d*)? l$/sgm)
{											# bepaling verschillende X- en Y-waarden van eindpunten van segmenten
	$X{$1} = undef;
	$X{$3} = undef;
	$Y{$2} = undef;
	$Y{$4} = undef;
}

$z=-1;
$dz=1;#-$curly;
for ( sort { $a <=> $b } keys %X) {
	$dz=1;#-$dz*$curly;
	$z+=$dz;
	$X{$_}=$z;
	$maxX=$z;
}

$z=-1;
$dz=1;#-$curly;
for ( sort { $a <=> $b } keys %Y) {
	$dz=1;#-$dz*$curly;
	$z+=$dz;
	$Y{$_}=$z;
	$maxY=$z;
}

for my $y (0 .. 2*$maxY){
	for my $x (0 .. 2*$maxX){
		$pr[$y][$x]=($y%2 || $x%2 ? " " : "+");
	}
}




@ARGV = @OARG;
$_ = <>;
s/.* w$//ms;
s/^endstream.*//ms;
s/^\d+(?:\.\d*)? \d+(?:\.\d*)? \d+(?:\.\d*)? \d+(?:\.\d*)? (\d+(?:\.\d*)? \d+(?:\.\d*)?) c$/\1 l/sgm;
$f = $_;
while( $f =~ /^(\d+)(?:\.\d*)? (\d+)(?:\.\d*)? m.(\d+)(?:\.\d*)? (\d+)(?:\.\d*)? l$/sgm )
{
	if ($X{$1}==$X{$3}){ #verticale lijnen
		for (($Y{$2}<$Y{$4} ? $Y{$2} : $Y{$4}) .. ($Y{$2}<$Y{$4} ? $Y{$4} : $Y{$2}) - 1){
			$pr[2*($maxY-$_)-1][2*$X{$1}] = "|";
		}
	}
	elsif ($Y{$2} == $Y{$4}) { 
		for (($X{$1}<$X{$3} ? $X{$1} : $X{$3}) .. ($X{$1}<$X{$3} ? $X{$3} : $X{$1}) - 1){
			$pr[2*($maxY-$Y{$2})][2*$_+1] = "-";
		}
	}
}

for my $y (0..2*$maxY){
	print @{$pr[$y]},"\n";
}