# mogelijkheid 1

@N = ("nul","een","twee","drie","vier","vijf","zes","zeven","acht","negen","tien","elf","twaalf");

@X = split " ",<>;

%X = map{$_,undef} @X;
print join " ", sort keys %X;
print "\n";

@Y = split " ",<>;
delete @X{@Y};

# dit is de oplossingsregel
print join " ", map{$N[$_]} grep {exists $X{$N[$_]}} 0..$#N;
#print join " ", sort keys %X;
print "\n";

# mogelijkheid 2

# eerst inverse nemen van de tabel
%N = map {$N[$_],$_} 0..$#N;

print $N{"Vier"};

@X = split " ",<>;

%X = map{$_,undef} @X;

# oplossingsregel
print join " ", sort {$N{$a} <=> $N{$b}} keys %X;
print "\n";

@Y = split " ",<>;
delete @X{@Y};

#print join " ", map{$N[$_]} grep {exists $X{$N[$_]}} 0..$#N;
#print join " ", sort keys %X;
print "\n";



__DATA__
drie een zeven drie twee negen vier vijf nul twaalf vijf negen vijf drie
drie zeven twaalf