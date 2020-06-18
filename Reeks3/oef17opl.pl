@ORGV = @ARGV;

while (<>) {                                  # bepaling roosterdimensies
  if (m[<title>([0-9]+) by ([0-9]+).*</title>]) {
    ($X,$Y)=($1,$2);
  last;
  }
}

for $y (1..$Y) {
  for $x (1..$X) {
    $z=($y-1)*$X+$x;                          # lineaire celnummerinig

    # @buren: geïndexeerd door celnummer -> lijst van vier buren

    $buren[$z][0]=($y==1  ? 0 : $z-$X);       # bovenbuur
    $buren[$z][1]=($x==1  ? 0 : $z-1);        # linkerbuur
    $buren[$z][2]=($x==$X ? 0 : $z+1);        # rechterbuur
    $buren[$z][3]=($y==$Y ? 0 : $z+$X);       # onderbuur

    # %rand: geïndexeerd door co�rdinaten uiteinden
    #        -> 2D tabel cellen en locatie rand t.o.v. corresponderende cel
    $x1=$x;
    $x2=$x+1;
    $y1=$y;
    $y2=$y+1;
    push @{$rand{$x1}{$y1}{$x2}{$y1}},[$z,0]; # bovenrand
    push @{$rand{$x1}{$y1}{$x1}{$y2}},[$z,1]; # linkerrand
    push @{$rand{$x2}{$y1}{$x2}{$y2}},[$z,2]; # rechterrand
    push @{$rand{$x1}{$y2}{$x2}{$y2}},[$z,3]; # onderrand
  }
}

print "\n# Burenlijst (hindernissen negerend):\n\n";

for $z (1..$#buren) {
  print "$z:\t";
  print join "\t",@{$buren[$z]};
  print "\n";
}

while (<>) {                                  # stockering coördinaten grenslijnen uit bestand
    push @lijnen,[$1,$2,$3,$4] if /(?:line x1=")([0-9]+)(?:" y1=")([0-9]+)(?:" x2=")([0-9]+)(?:" y2=")([0-9]+)/;
}

$width = 16;
for (@lijnen) {
  ($a,$b,$c,$d)=@{$_};                        # rekening houden met volgorde indexering in %rand
  ($a,$b,$c,$d)=($c,$d,$a,$b) if $a>$c;
  ($a,$b,$c,$d)=($c,$d,$a,$b) if ($a==$c && $b>$d);
  $_/=$width for ($a,$b,$c,$d);
  $dx=$c-$a;
  $dy=$d-$b;
  $dx/=abs($dx) if $dx;
  $dy/=abs($dy) if $dy;
  $x1=$a;
  $y1=$b;

  do {                                        # eliminatie buren langs segment(en) grenslijn
    $x2=$x1+$dx;
    $y2=$y1+$dy;
    for (@{$rand{$x1}{$y1}{$x2}{$y2}}) {
      $buren[$_->[0]][$_->[1]]=undef;
    }
    ($x1,$y1)=($x2,$y2);
  } until ($x2==$c && $y2==$d);
}

print "\n# Burenlijst (rekening houdend met hindernissen):\n\n";

for $z (1..$#buren) {

  # voor elke cel: vervanging tabel van vier buren door hash met overblijvende buren

  $buren[$z]={map {$_,undef} grep {defined $_} @{$buren[$z]}};
  print "$z:\t";
  print join "\t",sort {$a <=> $b} keys %{$buren[$z]};
  print "\n";
}

print "\n# Eindcellen in opeenvolgende iteraties:\n\n";

while (1) {

  # @eindcellen = cellen met elk slechts 1 effectieve buur

  @eindcellen=grep {keys %{$buren[$_]} == 1} grep {defined $buren[$_]} 1..$#buren;
  last unless @eindcellen;
  print "- @eindcellen\n";

  for my $z1 (@eindcellen) {
    my ($z2)=keys %{$buren[$z1]};
    delete $buren[$z2]{$z1};   # eliminatie buurcel uit burenlijst enige buur
    $buren[$z1]=undef;         # eliminatie burenlijst eindcel zelf
  }
}

print "\n# Burenlijst na eliminatie doodlopende paden:\n\n";

for $z (1..$#buren) {
  next unless $buren[$z];
  print "$z:\t";
  print join "\t",keys %{$buren[$z]};
  print "\n";
}

print "\n# Pad:\n\n";

$z2=0;
while (++$z2) {                # opsporen ��n van de twee uitgangen
  next unless defined($buren[$z2]);
  last if ((grep {$_==0} keys %{$buren[$z2]})>0);
}

@pad=();
$z1=0;
while (1) {                    # aflopen pad tussen beide uitgangen
  push @pad,$z2;
  delete $buren[$z2]{$z1};
  $z1=$z2;
  ($z2)=keys %{$buren[$z2]};
  last unless $z2;
}
print "@pad\n";

@ARGV = @ORGV;
undef $/;
$^I=".bak";
$_=<>;                         # verwerken bestand in r/w modus
/(.*<\/title>.)(.*)/s;         # bepaling locatie waar extra <g> element moet komen
print "$1  <g fill=\"#FF0000\" stroke=\"none\">\n";

while ($_=pop @pad) {          # kleuren individuele cellen op pad
  $z=$_-1;
  $x1=($z%$X+1)*$width;
  $x2=$x1+$width;
  $y1=(int($z/$X)+1)*$width;
  $y2=$y1+$width;
                               # toevoeging inhoud extra <g> element
  print "    <polygon points=\"$x1,$y1 $x2,$y1 $x2,$y2 $x1,$y2\" />\n";
}

print "  </g>\n$2";