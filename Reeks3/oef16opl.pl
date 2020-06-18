@OARG=@ARGV;
undef $/;                    # slurp mode
$_ = <>;                     # bestand eerste keer inlezen
s/.* w$//ms;                 # elimineren niet-relevante gegevens
s/^endstream.*//ms;
                             # rechte of gekromde lijnen ?
                             # indien gekromde lijnen: enkel �nteresse in eindpunten van segmenten
$curly = (s/^\d+(?:\.\d*)? \d+(?:\.\d*)? \d+(?:\.\d*)? \d+(?:\.\d*)? (\d+(?:\.\d*)? \d+(?:\.\d*)?) c$/\1 l/gsm ? 1 : 0 );
$f = $_;
while ( $f =~ /^(\d+)(?:\.\d*)? (\d+)(?:\.\d*)? m.(\d+)(?:\.\d*)? (\d+)(?:\.\d*)? l$/sgm )
{                            # bepaling verschillende X- en Y-waarden van eindpunten van segmenten
    $X{$1} = undef;
    $X{$3} = undef;
    $Y{$2} = undef;
    $Y{$4} = undef;
}

$z=-1;                       # mappen verschillende X-waarden op kolomnummers
$dz=1-$curly;  
for (sort {$a <=> $b} keys %X) {
  $dz=1-$dz*$curly;          # individueel indien rechte lijnen, in groepjes van twee indien gekromde lijnen
  $z+=$dz;
  $X{$_}=$z;
  $maxX =$z;                 # grootste kolomnummer
}

$z=-1;                       # mappen verschillende Y-waarden op rijnummers
$dz=1-$curly;
for (sort {$a <=> $b} keys %Y) {
  $dz=1-$dz*$curly;          # individueel indien rechte lijnen, in groepjes van twee indien gekromde lijnen
  $z+=$dz;
  $Y{$_}=$z;
  $maxY =$z;                 # grootste rijnummer
}

for my $y (0..2*$maxY) {     # initialiseren output
  for my $x (0..2*$maxX) {
    $pr[$y][$x]=($y%2  || $x%2 ? " " : "+");
  }
}

@ARGV=@OARG;
$_ = <>;                     # bestand tweede keer inlezen en analoog verwerken
s/.* w$//ms;
s/^endstream.*//ms;
s/^\d+(?:\.\d*)? \d+(?:\.\d*)? \d+(?:\.\d*)? \d+(?:\.\d*)? (\d+(?:\.\d*)? \d+(?:\.\d*)?) c$/\1 l/sgm;
$f = $_;
while ( $f =~ /^(\d+)(?:\.\d*)? (\d+)(?:\.\d*)? m.(\d+)(?:\.\d*)? (\d+)(?:\.\d*)? l$/sgm )
{                            # bepaling eindpunten van segmenten, nu gemapt op kolom- en rijnummers
    if ($X{$1}==$X{$3}) {    # vertikale lijen
      for (($Y{$2}<$Y{$4} ? $Y{$2} : $Y{$4})..($Y{$2}<$Y{$4} ? $Y{$4} : $Y{$2})-1) {
	$pr[2*($maxY-$_)-1][2*$X{$1}]="|";
      }
    }
    elsif ($Y{$2}==$Y{$4}) { # horizontale lijen
      for (($X{$1}<$X{$3} ? $X{$1} : $X{$3})..($X{$1}<$X{$3} ? $X{$3} : $X{$1})-1) {
	$pr[2*($maxY-$Y{$2})][2*$_+1]="-";
      }
    }
}

for my $y (0..2*$maxY) {
    print @{$pr[$y]},"\n";
}