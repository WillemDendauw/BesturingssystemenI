#Here's part of the family tree from the Bible:

%father = ( 'Cain'      => 'Adam',
            'Abel'      => 'Adam',
            'Seth'      => 'Adam',
            'Enoch'     => 'Cain',
            'Irad'      => 'Enoch',
            'Mehujael'  => 'Irad',
            'Methusael' => 'Mehujael',
            'Lamech'    => 'Methusael',
            'Jabal'     => 'Lamech',
            'Jubal'     => 'Lamech',
            'Tubalcain' => 'Lamech',
            'Enos'      => 'Seth' );

#this lets us for isntance easily trace a person's lineage:

while(<DATA>){
	chomp;
	do{
		print "$_ ";
		$_ = $father{$_};
	} while defined;
	print "\n";
}


#We can already ask questions like "Who begat Seth?" by checking the %father hash. By inverting this hash, we invert the
#relationship. This lets us use reeks 2 vraag 35 to answer questions like "Whom did Lamech beget?"

while(($k,$v) = each %father) {
	push( @{$children{$v} }, $k);
}

$" = ', '; #seperate output with commas
while(<DATA>) {
	chomp;
	if($children{$_}) {
		@children = @{$children{$_}};
	} else {
		@children = "nobody";
	}
	print "$_ begat @children.\n";
}

#Hashes can also represent relationships such as the C language #include s. A includes B if A contains #include B. This code
#builds the hash (it doesn't look for files in /usr/include as it should, but that's a minor change):


__DATA__
Cain