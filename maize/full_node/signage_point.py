from dataclasses import dataclass
from typing import Optional

from maize.types.blockchain_format.vdf import VDFInfo, VDFProof
from maize.util.streamable import Streamable, streamable


@streamable
@dataclass(frozen=True)
class SignagePoint(Streamable):
    cc_vdf: Optional[VDFInfo]
    cc_proof: Optional[VDFProof]
    rc_vdf: Optional[VDFInfo]
    rc_proof: Optional[VDFProof]
