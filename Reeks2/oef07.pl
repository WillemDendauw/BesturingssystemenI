#Verwerk een bestand lijn per lijn, waarbij rekening gehouden wordt met continuation karakters,
#bijvoorbeeld backslashes op het einde van een lijn, zoals in volgend voorbeeld:
#DISTFILES = $(DIST_COMMON) $(SOURCES) $(HEADERS) \
#        $(TEXINFOS) $(INFOS) $(MANS) $(DATA)
#DEP_DISTFILES = $(DIST_COMMON) $(SOURCES) $(HEADERS) \
#        $(TEXINFOS) $(INFO_DEPS) $(MANS) $(DATA) \
#        $(EXTRA_DIST)

while(defined($line = <FH>)){
	chomp $line;
	if($line =~s/\\$//) {
		$line .= <FH>;
		redo unless eof(FH);
	}
}