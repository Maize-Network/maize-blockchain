import os
from pathlib import Path

DEFAULT_ROOT_PATH = Path(os.path.expanduser(os.getenv("MAIZE_ROOT", "~/.maize/mainnet"))).resolve()

DEFAULT_KEYS_ROOT_PATH = Path(os.path.expanduser(os.getenv("MAIZE_KEYS_ROOT", "~/.maize_keys"))).resolve()
