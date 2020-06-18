#Veronderstel dat je over twee correcte atomaire reguliere expressies beschikt: /ALPHA/ en /BETA/.
#Construeer achtereenvolgens een reguliere expressie die:
	#waar is indien hetzij /ALPHA/ of /BETA/ waar is, of beiden,
	#waar is indien zowel /ALPHA/ als /BETA/ waar zijn, en waarbij de overeenkomstige substrings mogen overlappen,
	#waar is indien zowel /ALPHA/ als /BETA/ waar zijn, zonder dat de overeenkomstige substrings mogen overlappen,
	#waar is indien /ALPHA/ niet waar is (en $_ !~ /ALPHA/ bijgevolg wel waar is),
	#waar is indien /ALPHA/ niet waar is, maar /BETA/ wel.


/APHA|BETA/

/^(?=.*ALPHA)BETA/s

#?= postitive lookahead

/ALPHA.*BETA|BETA.*ALPHA/s

/^(?:(?!ALPHA).)*$/s

/(?=^(?:(?!ALPHA).)*$)BETA/s

#When in a normal program you want to know whether something doesn't match, use one of:

    if (!($string =~ /pattern/)) { something( ) }   # ugly
    if (  $string !~ /pattern/)  { something( ) }   # preferred
unless (  $string =~ /pattern/)  { something( ) }   # sometimes clearer


#To see whether both patterns match, use:

if ($string =~ /pat1/ && $string =~ /pat2/ ) { something( ) }
#To see whether either of two patterns matches:

if ($string =~ /pat1/ || $string =~ /pat2/ ) { something( ) }




if ($murray_hill =~ m{
             ^              # start of string
            (?=             # zero-width lookahead
                .*          # any amount of intervening stuff
                bell        # the desired bell string
            )               # rewind, since we were only looking
            lab             # and the lab part
         }sx )              # /s means . can match newline
{
    print "Looks like Bell Labs might be in Murray Hill!\n";
}


#overlap
$brand = "labelled";
if ($brand =~ m{
        (?:                 # non-capturing grouper
              bell          # look for a bell
              .*?           # followed by any amount of anything
              lab           # look for a lab
          )                 # end grouper
    |                       # otherwise, try the other direction
        (?:                 # non-capturing grouper
              lab           # look for a lab
              .*?           # followed by any amount of anything
              bell          # followed by a bell
          )                 # end grouper
    }sx )                   # /s means . can match newline
{
    print "Our brand has bell and lab separate.\n";
}


#efficiënter
if ($map =~ m{
        ^                   # start of string
        (?:                 # clustering grouper
            (?!             # look ahead negation
                waldo       # is he ahead of us now?
            )               # is so, the negation failed
            .               # any character (cuzza /s)
        ) *                 # repeat that grouping 0 or more
        $                   # through the end of the string
    }sx )                   # /s means . can match newline
{
    print "There's no waldo here!\n";
}



m{
    (?!                     # zero-width look-ahead assertion
        .*                  # any amount of anything (faster than .*?)
        ttyp                # the string you don't want to find
    )                       # end look-ahead negation; rewind to start
    tchrist                 # now try to find Tom
}x