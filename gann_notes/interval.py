import math
from gann_notes.utils import OTTAVA

class Interval:

    right_delim = '<'
    left_delim = '>'
    repr_with_cents = True
    repr_with_pitch = True
    repr_with_fund = True
    num = 1
    den = 1
    fundamental = 440

    def __eq__(self, other):
        if isinstance(other, Interval):
            return self.num == other.num and self.den == other.den
        else:
            return False

    def __repr__(self):
        if self.repr_with_cents:
            return f"{self.right_delim}{self.num}/{self.den} ({self.to_cent()}¢){self.left_delim}"
        else:
            return f"{self.right_delim}{self.num}/{self.den}{self.left_delim}"

    def __add__(self, other):
        if isinstance(other, Interval):
            if self.fundamental == other.fundamental:
                return Interval(self.num * other.num, self.den * other.den)
            else:
                raise ValueError("cannot add intervals with different fundamental frequencies")
        else:
            raise TypeError(f"unsupported operand type(s) for +: 'Interval' and '{type(other)}'")
        
    def __sub__(self, other):
        if isinstance(other, Interval):
            if self.fundamental == other.fundamental:
                return Interval(self.num * other.den, self.den * other.num)
            else:
                raise ValueError("cannot subtract intervals with different fundamental frequencies")
        else:
            raise TypeError(f"unsupported operand type(s) for -: 'Interval' and '{type(other)}'")
        

    def __setattr__(self, __name: str, __value: any) -> None:
        if __name == 'num' or __name == 'den':
            if not isinstance(__value, int):
                raise TypeError(f"expected int, got '{type(__value)}'")
            if __value < 0:
                raise ValueError("expected non-negative value")
            if __name == 'den' and __value == 0:
                raise ValueError("expected non-zero value for denominator")
            if __name == 'num':
                new_num, new_den = self.reduce(__value, self.den)
                super().__setattr__('num', new_num)
                super().__setattr__('den', new_den)
            elif __name == 'den':
                new_num, new_den = self.reduce(self.num, __value)
                super().__setattr__('num', new_num)
                super().__setattr__('den', new_den)

    def __init__(self, num, den, fund=440):
        self.num, self.den = self.reduce(num, den)
        self.fundamental = fund

    def to_cent(self):
        return abs(math.log10(self.num / self.den)) * OTTAVA
    
    def to_hertz(self):
        return (self.num/self.den) * self.fundamental

    @classmethod
    def is_reduced(cls, num, den):
        return math.gcd(num, den) == 1

    @classmethod
    def reduce(cls, num, den):
        gcd = math.gcd(num, den)
        x, y = num // gcd, den // gcd
        if cls.is_reduced(x, y):
            return (x, y)
        else:
            cls.reduce(x, y)

    def raise_octaves(self, n, in_place=True):
        if in_place:
            self.num *= (2 ** n)
            return self
        else:
            return Interval(self.num * (2 ** n), self.den)
    
    def lower_octaves(self, n, in_place=True):
        if in_place:
            self.den *= (2 ** n)
            return self
        else:
            return Interval(self.num, self.den * (2**n))
        
    def repr_only_ratio(self):
        self.repr_with_cents = False
        self.repr_with_fund = False
        self.repr_with_pitch = False
