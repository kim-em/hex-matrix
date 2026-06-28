# hex-matrix

Dense integer-matrix core for the `hex` project: dense matrix operations,
row-echelon transforms, determinant APIs, and the executable Bareiss
determinant algorithm over `Int`. Mathlib-free.

```
require HexMatrix from git "https://github.com/kim-em/hex-matrix.git" @ "<rev>"
```

- Mathlib correspondence proofs live in
  [`hex-matrix-mathlib`](https://github.com/kim-em/hex-matrix-mathlib).
- Benchmarks live in [`bench/`](bench) (own lakefile; pulls `lean-bench`).
- Conformance fixtures/oracles live in [`conformance/`](conformance) (own lakefile).
- Spec: [SPEC/hex-matrix.md](SPEC/hex-matrix.md).

## Verification

Build the library from the repository root:

```sh
lake build
```

Build the conformance sidecar through Lake, not by invoking `lake env lean`
directly on `conformance/HexMatrix/Conformance.lean`:

```sh
cd conformance
lake build HexMatrixConformance
```

The conformance file evaluates Bareiss fixtures that use `Matrix.exactDiv`,
whose native implementation is provided through generated C code. A direct
`lake env lean` run does not link the compiled native implementation needed for
those `#guard`s.

Development happens in the [`hex-dev`](https://github.com/kim-em/hex-dev) monorepo.
