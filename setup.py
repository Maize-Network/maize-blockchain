import os

from setuptools import setup

dependencies = [
    "aiofiles==0.7.0",  # Async IO for files
    "blspy==1.0.15",  # Signature library
    "chiavdf==1.0.6",  # timelord and vdf verification
    "chiabip158==1.1",  # bip158-style wallet filters
    "chiapos==1.0.10",  # proof of space
    "clvm==0.9.7",
    "clvm_tools==0.4.5",  # Currying, Program.to, other conveniences
    "chia_rs==0.1.10",
    "clvm-tools-rs==0.1.19",  # Rust implementation of clvm_tools' compiler
    "aiohttp==3.8.1",  # HTTP server for full node rpc
    "aiosqlite==0.17.0",  # asyncio wrapper for sqlite, to store blocks
    "bitstring==3.1.9",  # Binary data management library
    "colorama==0.4.5",  # Colorizes terminal output
    "colorlog==6.6.0",  # Adds color to logs
    "concurrent-log-handler==0.9.19",  # Concurrently log and rotate logs
    "cryptography==36.0.2",  # Python cryptography library for TLS - keyring conflict
    "filelock==3.7.1",  # For reading and writing config multiprocess and multithread safely  (non-reentrant locks)
    "keyring==23.6.0",  # Store keys in MacOS Keychain, Windows Credential Locker
    "keyrings.cryptfile==1.3.4",  # Secure storage for keys on Linux (Will be replaced)
    #  "keyrings.cryptfile==1.3.8",  # Secure storage for keys on Linux (Will be replaced)
    #  See https://github.com/frispete/keyrings.cryptfile/issues/15
    "PyYAML==6.0",  # Used for config file format
    "setproctitle==1.2.3",  # Gives the maize processes readable names
    "sortedcontainers==2.4.0",  # For maintaining sorted mempools
    # TODO: when moving to click 8 remove the pinning of black noted below
    "click==7.1.2",  # For the CLI
    "dnspython==2.2.0",  # Query DNS seeds
    "watchdog==2.1.9",  # Filesystem event watching - watches keyring.yaml
    "dnslib==0.9.17",  # dns lib
    "typing-extensions==4.3.0",  # typing backports like Protocol and TypedDict
    "zstd==1.5.2.6",
    "packaging==21.3",
    "psutil==5.9.1",
]

upnp_dependencies = [
    "miniupnpc==2.2.2",  # Allows users to open ports on their router
]

dev_dependencies = [
    "build",
    "coverage",
    "diff-cover",
    "pre-commit",
    "py3createtorrent",
    "pylint",
    "pytest",
    "pytest-asyncio>=0.18.1",  # require attribute 'fixture'
    "pytest-cov",
    "pytest-monitor; sys_platform == 'linux'",
    "pytest-xdist",
    "twine",
    "isort",
    "flake8",
    "mypy",
    # TODO: black 22.1.0 requires click>=8, remove this pin after updating to click 8
    "black==21.12b0",
    "aiohttp_cors",  # For blackd
    "ipython",  # For asyncio debugging
    "pyinstaller==5.3",
    "types-aiofiles",
    "types-click~=7.1",
    "types-cryptography",
    "types-pkg_resources",
    "types-pyyaml",
    "types-setuptools",
]

kwargs = dict(
    name="maize-blockchain",
    author="Maize Network",
    author_email="hello@maize.farm",
    description="Maize blockchain full node, farmer, timelord, and wallet.",
    url="https://maize.farm/",
    license="Apache License",
    python_requires=">=3.7, <4",
    keywords="maize blockchain node",
    install_requires=dependencies,
    extras_require=dict(
        uvloop=["uvloop"],
        dev=dev_dependencies,
        upnp=upnp_dependencies,
    ),
    packages=[
        "build_scripts",
        "maize",
        "maize.cmds",
        "maize.clvm",
        "maize.consensus",
        "maize.daemon",
        "maize.data_layer",
        "maize.full_node",
        "maize.timelord",
        "maize.farmer",
        "maize.harvester",
        "maize.introducer",
        "maize.plot_sync",
        "maize.plotters",
        "maize.plotting",
        "maize.pools",
        "maize.protocols",
        "maize.rpc",
        "maize.seeder",
        "maize.server",
        "maize.simulator",
        "maize.types.blockchain_format",
        "maize.types",
        "maize.util",
        "maize.wallet",
        "maize.wallet.db_wallet",
        "maize.wallet.puzzles",
        "maize.wallet.cat_wallet",
        "maize.wallet.did_wallet",
        "maize.wallet.nft_wallet",
        "maize.wallet.settings",
        "maize.wallet.trading",
        "maize.wallet.util",
        "maize.ssl",
        "mozilla-ca",
    ],
    entry_points={
        "console_scripts": [
            "maize = maize.cmds.maize:main",
            "maize_daemon = maize.daemon.server:main",
            "maize_wallet = maize.server.start_wallet:main",
            "maize_full_node = maize.server.start_full_node:main",
            "maize_harvester = maize.server.start_harvester:main",
            "maize_farmer = maize.server.start_farmer:main",
            "maize_introducer = maize.server.start_introducer:main",
            "maize_crawler = maize.seeder.start_crawler:main",
            "maize_seeder = maize.seeder.dns_server:main",
            "maize_timelord = maize.server.start_timelord:main",
            "maize_timelord_launcher = maize.timelord.timelord_launcher:main",
            "maize_full_node_simulator = maize.simulator.start_simulator:main",
            "maize_data_layer = maize.server.start_data_layer:main",
            "maize_data_layer_http = maize.data_layer.data_layer_server:main",
        ]
    },
    package_data={
        "maize": ["pyinstaller.spec"],
        "": ["*.clvm", "*.clvm.hex", "*.clib", "*.clinc", "*.clsp", "py.typed"],
        "maize.util": ["initial-*.yaml", "english.txt"],
        "maize.ssl": ["maize_ca.crt", "maize_ca.key", "dst_root_ca.pem"],
        "mozilla-ca": ["cacert.pem"],
    },
    long_description=open("README.md").read(),
    long_description_content_type="text/markdown",
    zip_safe=False,
    project_urls={
        "Source": "https://github.com/Chia-Network/maize-blockchain/",
        "Changelog": "https://github.com/Chia-Network/maize-blockchain/blob/main/CHANGELOG.md",
    },
)


if len(os.environ.get("MAIZE_SKIP_SETUP", "")) < 1:
    setup(**kwargs)  # type: ignore
