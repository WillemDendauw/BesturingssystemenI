#Verwerk de elementen van een array, zoals je dat met pop of shift zou doen, maar nu meerdere elementen ineens

#splice gebruiken

#remove $N elements from front of @array (shift $N)

@front = splice(@array, 0, $N);

#remove $N elements from the end of the array (pop $N)
@end = splice(@array, -$N);


#splice(array,offset,length,list)
#push(@a, $x, $y)			splice(@a, @a, 0, $x, $y)
#pop(@a)						splice(@a, -1)
#shift(@a)					splice(@a, 0, 1)
#unshift(@a, $x, $y)			splice(@a, 0, 0, $x, $y)
#$a[$x] = $y					splice(@a, $x, 1, $y)
#(@a, @a = ( ))				splice(@a)