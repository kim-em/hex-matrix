#!/usr/bin/env bash
# Conformance oracle runner for hex-matrix.
#
# HexMatrix conformance is an oracle-free #guard module (it carries no
# python-flint cross-check), so there are no oracles to run here. The CI
# step invokes this script unconditionally; it succeeds trivially.

set -uo pipefail

echo "Conformance: HexMatrix is oracle-free (#guard module); no oracles to run."
