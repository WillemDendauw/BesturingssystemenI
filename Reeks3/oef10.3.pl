#Hashes can also represent relationships such as the C language #include s. A includes B if A contains #include B. This code
#builds the hash (it doesn't look for files in /usr/include as it should, but that's a minor change):

foreach $file (@ARGV) {
    local *FH;
    unless (open(FH, " < $file")) {
        warn "Couldn't read $file: $!; skipping.\n";
        next;
    }

    while (<FH>) {
        next unless /^\s*#\s*include\s*<([^>]+)>/;
        push(@{$includes{$1}}, $file);
    }
    close FH;
}

#This shows which files with include statements are not included in other files:

@include_free = ( );                 # list of files that don't include others
@uniq{map { @$_ } values %includes} = undef;
foreach $file (sort keys %uniq) {
        push( @include_free , $file ) unless $includes{$file};
}