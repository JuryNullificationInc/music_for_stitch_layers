import math
from typing import Any

OTTAVA = 1200/math.log10(2)

def harmonic_mean(x: float, y: float) -> float:
    return 2 * x * y / (x + y)


