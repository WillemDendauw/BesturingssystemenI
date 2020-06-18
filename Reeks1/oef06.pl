#Rond a willekeurig floating-point getal af op een vooropgezet aantal decimale cijfers (na de komma).
#Dit is ondermeer interessant om de uitvoer beter leesbaar te maken, en bij problemen met het testen op gelijkheid (zie vraag 7).

# Use the Perl function sprintf, or printf if you're just trying to produce output:

# round off to two places
$rounded = sprintf("%.2f", $unrounded);
# Or you can use other rounding functions described in the Discussion.


# Bespreking
# Whether visible or not, rounding of some sort is virtually unavoidable when working with floating-point numbers. Carefully defined standards (namely, IEEE 754, the standard for binary floating-point arithmetic) coupled with reasonable defaults within Perl often manage to eliminate or at least hide these round-off errors.

# In fact, Perl's implicit rounding on output is usually good enough so that it rarely surprises. It's almost always best to leave the numbers unrounded until output, and then, if you don't like Perl's default rounding, use printf or sprintf yourself with a format that makes the rounding explicit. The %f, %e, and %g formats all let you specify how many decimal places to round their argument to. Here's an example showing how all three behave; in each case, we're asking for a field that's 12 spaces wide, but with a precision of no more than four digits to the right of the decimal place.

# for $n ( 0.0000001, 10.1, 10.00001, 100000.1 ) {
#     printf "%12.4e %12.4f %12.4g\n", $n, $n, $n;
# }
# This produces the following output:

# 1.0000e-07       0.0000        1e-07
# 1.0100e+01      10.1000         10.1
# 1.0000e+01      10.0000           10
# 1.0000e+05  100000.1000        1e+05
# If that were all there were to the matter, rounding would be pretty easy. You'd just pick your favorite output format and be done with it.

# However, it's not that easy: sometimes you need to think more about what you really want and what's really happening. Even a simple number like 10.1 or 0.1 can only be approximated in binary floating-point. The only decimal numbers that can be exactly represented as floating-point numbers are those that can be rewritten as a finite sum of one or more fractions whose denominators are all powers of two. For example:

# $a = 0.625;                # 1/2 + 1/8
# $b = 0.725;                # 725/1000, or 29/40
# printf "$_ is %.30g\n", $_ for $a, $b;
# prints out:

# 0.625 is 0.625
# 0.725 is 0.724999999999999977795539507497
# The number in $a is exactly representable in binary, but the one in $b is not. When Perl is told to print a floating-point number but not told the precision, as occurs for the interpolated value of $_ in the string, it automatically rounds that number to however many decimal digits of precision that your machine supports. Typically, this is like using an output format of "%.15g", which, when printed, produces the same number as you assigned to $b.

# Usually the round-off error is so small you never even notice it, and if you do, you can always specify how much precision you'd like in your output. But because the underlying approximation is still a little bit off from what a simple print might show, this can produce unexpected results. For example, while numbers such as 0.125 and 0.625 are exactly representable, numbers such as 0.325 and 0.725 are not. So let's suppose you'd like to round to two decimal places. Will 0.325 become 0.32 or 0.33? Will 0.725 become 0.72 or 0.73?

# $a = 0.325;                # 1/2 + 1/8
# $b = 0.725;                # 725/1000, or 29/40
# printf "%s is %.2f or %.30g\n", ($_) x 3 for $a, $b;
# This produces:

# 0.325 is 0.33 or 0.325000000000000011102230246252
# 0.725 is 0.72 or 0.724999999999999977795539507497
# Since 0.325's approximation is a bit above that, it rounds up to 0.33. On the other hand, 0.725's approximation is really a little under that, so it rounds down, giving 0.72 instead.

# But what about if the number is exactly representable, such 1.5 or 7.5, since those are just whole numbers plus one-half? The rounding rule used in that case is probably not the one you learned in grade school. Watch:

# for $n (-4 .. +4) {
#     $n += 0.5;
#     printf "%4.1f %2.0f\n", $n, $n;
# }
# That produces this:

# -3.5 -4
# -2.5 -2
# -1.5 -2
# -0.5 -0
#  0.5  0
#  1.5  2
#  2.5  2
#  3.5  4
#  4.5  4
# What's happening is that the rounding rule preferred by numerical analysts isn't "round up on a five," but instead "round toward even." This way the bias in the round-off error tends to cancel itself out.

# Three useful functions for rounding floating-point values to integral ones are int, ceil, and floor. Built into Perl, int returns the integral portion of the floating-point number passed to it. This is called "rounding toward zero." This is also known as integer truncation because it ignores the fractional part: it rounds down for positive numbers and up for negative ones. The POSIX module's floor and ceil functions also ignore the fractional part, but they always round down and up to the next integer, respectively, no matter the sign.

# use POSIX qw(floor ceil);
# printf "%8s %8s %8s %8s %8s\n", 
#     qw(number even zero down up);
# for $n (-6 .. +6) {
#     $n += 0.5;
#     printf "%8g %8.0f %8s %8s %8s\n", 
#             $n, $n, int($n), floor($n), ceil($n);
# }
# This produces the following illustrative table; each column heading shows what happens when you round the number in the specified direction.

# number     even     zero     down       up
#   -5.5       -6       -5       -6       -5
#   -4.5       -4       -4       -5       -4
#   -3.5       -4       -3       -4       -3
#   -2.5       -2       -2       -3       -2
#   -1.5       -2       -1       -2       -1
#   -0.5       -0        0       -1        0
#    0.5        0        0        0        1
#    1.5        2        1        1        2
#    2.5        2        2        2        3
#    3.5        4        3        3        4
#    4.5        4        4        4        5
#    5.5        6        5        5        6
#    6.5        6        6        6        7
# If you add up each column, you'll see that you arrive at rather different totals:

#    6.5        6        6        0       13
# What this tells you is that your choice of rounding style—in effect, your choice of round-off error—can have tremendous impact on the final outcome. That's one reason why you're strongly advised to wait until final output for any rounding. Even still, some algorithms are more sensitive than others to accumulation of round-off error. In particularly delicate applications, such as financial computations and thermonuclear missiles, prudent programmers will implement their own rounding functions instead of relying on their computers' built-in logic, or lack thereof.

# Referenties
# The sprintf and int functions in perlfunc; the floor and ceil entries in the documentation for the standard POSIX module; the sprintf technique in vraag 7.