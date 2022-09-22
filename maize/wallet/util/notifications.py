from maize.types.blockchain_format.program import Program
from maize.types.blockchain_format.sized_bytes import bytes32
from maize.util.ints import uint64
from maize.wallet.puzzles.load_clvm import load_clvm

NOTIFICATION_MOD = load_clvm("notification.clvm")


def construct_notification(target: bytes32, amount: uint64) -> Program:
    return NOTIFICATION_MOD.curry(target, amount)
