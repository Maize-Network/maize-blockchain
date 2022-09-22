from dataclasses import dataclass

from maize.types.blockchain_format.program import Program


@dataclass(frozen=True)
class UncurriedPuzzle:
    mod: Program
    args: Program


def uncurry_puzzle(puzzle: Program) -> UncurriedPuzzle:
    return UncurriedPuzzle(*puzzle.uncurry())
