$aantal=1/2;
for my $prefix (reverse 0..32) {             # mapping prefixlengte <-> aantal adressen
  $aantal*=2;
  $aantal[$prefix]=$aantal;
  $prefix{$aantal}=$prefix;
}

$error=0;

for $net (@ARGV) {
  @ip=split /[.\/]/,$net;                    # 4 bytes netwerkadres + 1 byte prefixlenge
  splice @ip,(@ip-1),0,(0)x(5-@ip) if @ip<5; # eventueel aanvullen met 0 bytes
  $start=0;
  $start=$start*256+$ip[$_] for 0..3;        # compacte representatie netwerkadres
  if ($start%$aantal[$ip[4]]) {              # berekening minimale prefixlengte
    $ip[4]++ while $start%$aantal[$ip[4]];
    print "$net vereist minimaal /$ip[4]\n";
    $error++;
  }
  @V=([$start,$aantal[$ip[4]]]) unless @V    # initialiseren verzameling supernets
}

exit(0) if $error;

shift @ARGV;
while (@ARGV) {                              # verwerken subnets
  $sub=$ARGV[0];
  @ip=split /[.\/]/,$sub;
  splice @ip,(@ip-1),0,(0)x(5-@ip) if @ip<5;
  $start=0;
  $start=$start*256+$ip[$_] for 0..3;
  print "$start\n";
  my $ind=-1;
  my $found=0;
  for $super (@V) {                          # welk supernet bevat subnet ?
    $ind++;
    if ($start>=$super->[0] && $start<$super->[0]+$super->[1]) {
      $found=1;
      if($aantal[$ip[4]]==$super->[1]) {     # supernet verwijderen indien = subnet
	splice @V,$ind,1;
	shift @ARGV;                         # volgend subnet behandelen
      }
      elsif($aantal[$ip[4]]<$super->[1]) {   # supernet opsplitsen  indien > subnet
	$helft=$super->[1]/2;
	splice @V,$ind,1,([$super->[0],$helft],[$super->[0]+$helft,$helft]);
      }
      last;                                  # want toch geen overlappende supernetten mogelijk
    }
  }
  shift @ARGV unless $found;                 # subnet negeren indien supernet gevonden
}

for $v (@V) {
  @ip=();                                    # 4 bytes netwerkadres + 1 byte prefixlenge
  for $b (reverse 0..3) {
    $ip[$b]=$v->[0]%256;
    $v->[0]-=$ip[$b];
    $v->[0]/=256;
  }
  pop @ip while (@ip>1 && !$ip[-1]);         # trailing 0's verwijderen
  print join (".",@ip),"/$prefix{$v->[1]}\n";
}