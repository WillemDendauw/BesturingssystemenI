#Verwerk de elementen van een array circulair: na het laatste element moeten opnieuw het eerste en alle
#daaropvolgende elementen telkens opnieuw afgelopen worden.

#unshift en pop (of push en shift) op een array gebruiken

unshift(@circular, pop(@circular)); #de laatste zal de eerste zijn
push(@circular, shift(@circular)); #omgekeerd