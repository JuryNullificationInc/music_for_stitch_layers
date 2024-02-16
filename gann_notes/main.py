from scale_by_repetition import OneDimensionalScaleByRepetition
from interval import Interval

a = Interval(3, 2)
b = Interval(3, 2)
c = a + b

s = OneDimensionalScaleByRepetition(Interval(3, 2), 1, 2)
print(s)