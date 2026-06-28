# hex-matrix conformance

This sidecar package contains executable conformance checks and fixture
emitters for `hex-matrix`.

Run the conformance checks through Lake:

```sh
lake build HexMatrixConformance
```

Do not run `HexMatrix/Conformance.lean` directly with `lake env lean`. The
conformance guards evaluate Bareiss code that uses `Matrix.exactDiv`; its
native implementation is available when Lake builds the package, but direct
interpreter execution does not link the generated native code.

To emit JSONL fixtures for external oracles:

```sh
lake exe hexmatrix_emit_fixtures
```
