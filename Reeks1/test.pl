@N = ("nul","een","twee","drie","vier","vijf","zes","zeven","acht","negen","tien","elf","twaalf");
# %N = map {$N[$_],$_} 0..$#N;

# print $N{"Vier"};

# waarom werkt dit niet

for(0..$#N){
	print $_;
}

