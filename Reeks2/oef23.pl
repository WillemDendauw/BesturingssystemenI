#Om alle HTML-tags te verwijderen is
#s/<.*>//gs;
#een veel te simplistische oplossing, die onmiddellijk tot foutieve resultaten leidt indien in het blok dat
#men ineens aan het verwerken is (de lijn, de paragraaf of het ganse bestand), meer dan één tag voorkomt.
#Toch kun je met een minimale aanpassing van deze reguliere expressie veel betere resultaten te bekomen. Hoe?

#Replace the offending greedy quantifier with the corresponding non-greedy version. That is,
#change *, +, ?, and { } into *?, +?, ??, and { }?, respectively.

# greedy pattern
s/<.*>//gs;              # try to remove tags, very badly

# nongreedy pattern
s/<.*?>//gs;             # try to remove tags, better (but still rather badly)


m{
  BEGIN               # locate initial portion
  (                   # save this group into $1
      (?:             # non-capturing group
          (?! BEGIN)  # assert: can't be at another BEGIN
          .           # now match any one character
      ) *             # entire group 0 or more 
  )                   # end $1 group
  END                 # locate final portion
}sx




m{
    BEGIN           # locate initial portion
    (               # save this group into $1
        (?:         # non-capturing group
            (?! BEGIN   )   # can't be at a BEGIN 
            (?! END     )   # also can't be at an END
            .               # finally, match any one char
        ) *         # repeat entire group ad libitum
    )               # end $1 capture
    END
}sx





m{
    <b><i>
    [^<]*  # stuff not possibly bad, and not possibly the end.
    (?:
 # at this point, we can have '<' if not part of something bad
     (?! </?[ib]>  )    # what we can't have
     <                  # okay, so match the '<'
     [^<]*              # and continue with more safe stuff
   ) *
   </i> </b>
 }sx