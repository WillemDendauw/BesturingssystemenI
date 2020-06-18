#Verwijder een hash element met een specifieke index. Hoe kan dit veralgemeend worden tot meerdere elementen?

#delete gebruiken

delete($hash{$key});

#kan ook met meerdere tegelijk

delete @food_color{"Banana","Apple","Cabbage"};