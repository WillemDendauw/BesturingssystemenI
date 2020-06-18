# Hoe kun je best twee willekeurige floating-point getallen met elkaar vergelijken, enkel rekening houdend
# met een specifiek aantal decimale cijfers (na de komma) ?

# Use sprintf to format the numbers to a certain number of decimal places, then compare the resulting strings:

    my ($A, $B);
    if (sprintf("%.${dp}g", $A) eq sprintf("%.${dp}g", $B)) {...}
  }
# Alternatively, store the numbers as integers by assuming the decimal place.

# Bespreking
# You need the equal routine because computers' floating-point representations are just approximations of most real numbers. Perl's normal printing routines display numbers rounded to 15 decimal places or so, but its numeric tests don't round. So sometimes you can print out numbers that look the same (after rounding) but do not test the same (without rounding).

# This problem is especially noticeable in a loop, where round-off error can silently accumulate. For example, you'd think that you could start a variable out at zero, add one-tenth to it ten times, and end up with one. Well, you can't, because a base-2 computer can't exactly represent one-tenth. For example:

# for ($num = $i = 0; $i < 10; $i++) { $num += 0.1 }
# if ($num != 1) {
#     printf "Strange, $num is not 1; it's %.45f\n", $num;
# }
# prints out:

# Strange, 1 is not 1; it's 0.999999999999999888977697537484345957636833191
# The $num is interpolated into the double-quoted string using a default conversion format of "%.15g" (on most systems), so it looks like 1. But internally, it really isn't. If you had checked only to a few decimal places, for example, five, then you'd have been okay.

# If you have a fixed number of decimal places, as with currency, you can often sidestep the problem by storing your values as integers. Storing $3.50 as 350 instead of 3.5 removes the need for floating-point values. Reintroduce the decimal point on output:

# $wage = 536;                # $5.36/hour
# $week = 40 * $wage;         # $214.40
# printf("One week's wage is: \$%.2f\n", $week/100);

# One week's wage is: $214.40
# It rarely makes sense to compare more than 15 decimal places, because you probably only have that many digits of precision in your computer's hardware.

# Referenties
# The sprintf function in perlfunc; the entry on $OFMT in the perlvar manpage; use of sprintf in vraag 6;