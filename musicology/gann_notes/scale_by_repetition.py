from interval import Interval

class OneDimensionalScaleByRepetition:

    def __repr__(self):
        return f"{self.intervals}"

    def __init__(self, ntrvl, left_rep, right_rep):
        self.ntrvl = ntrvl
        self.left_rep = left_rep
        self.right_rep = right_rep
        self.intervals = self.stitch_intervals(self.left_interval(self.left_rep), self.right_interval(self.right_rep))
        [x.repr_only_ratio() for x in self.intervals]

    def left_interval(self, y: int, xs: list[Interval]=[Interval(1, 1)]) -> list[Interval]:
        if y == 0:
            return xs
        else:
            return self.left_interval(y - 1, [xs[0] - self.ntrvl] + xs)
        
    def right_interval(self, y: int, xs: list[Interval]=[Interval(1, 1)]) -> list[Interval]:
        if y == 0:
            return xs
        else:
            return self.right_interval(y - 1, xs + [xs[-1] + self.ntrvl])
        
    def stitch_intervals(self, xs: list[Interval], ys: list[Interval]) -> list[Interval]:
        if xs[-1] == ys[0]:
            return xs[:-1] + ys