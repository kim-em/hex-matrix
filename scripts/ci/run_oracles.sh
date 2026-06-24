#!/usr/bin/env bash
# Conformance oracle runner for hex-matrix (the released single-library
# split of the hex monorepo). Single-library version of the monorepo's
# scripts/ci/run_oracles.sh.
#
# Cross-checks the committed fixture against fresh Lean emission, then
# pipes the emission into the python-flint oracle for verification.
# Run from the repository root, after the library and the conformance
# sidecar have been built. FLINT (python-flint + libgmp-dev) must be
# installed; the workflow installs it before invoking this script.
#
# Exits non-zero on the first failing stage with a clear marker.

set -uo pipefail

lib="HexMatrix"
emit="hexmatrix_emit_fixtures"
oracle="scripts/oracle/matrix_flint.py"
fixture="conformance-fixtures/HexMatrix/matrix.jsonl"
fresh="/tmp/${lib}-fresh.jsonl"

echo
echo "=========================================================="
echo ">>> $lib :: emit=$emit oracle=$oracle"
echo "=========================================================="

# The emit exe lives in the conformance sidecar package; run it there
# but keep the fresh emission at an absolute path so the oracle (run
# from the repo root) can read it.
if ! (cd conformance && lake exe "$emit") >"$fresh"; then
  echo "FAIL: $lib :: lake exe $emit exited non-zero" >&2
  exit 1
fi

if ! diff -u "$fixture" "$fresh"; then
  echo "FAIL: $lib :: fresh emission diverges from committed fixture" >&2
  exit 1
fi

if ! python3 "$oracle" <"$fresh"; then
  echo "FAIL: $lib :: oracle $oracle reported a divergence" >&2
  exit 1
fi

echo "OK: $lib"
echo
echo "Conformance: all oracles passed."
