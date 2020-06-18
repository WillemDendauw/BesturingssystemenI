#Gebruik een reguliere expressie om uit een string in DD/MM/YYYY formaat de dag-, maand- en jaartallen
#te parsen.

($dd,$mm,$yyyy) = ($date =~ m{(\d+)/(\d+)/(\d+)});