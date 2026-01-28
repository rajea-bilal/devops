# Git at Scale

## Monorepos

- Single repo for many services.
- Used by large orgs.
- Simplifies sharing code.
- Makes CI more complex.

---

## Selective Builds

Tools:
- Nx
- Turborepo
- Bazel

- Only test changed areas.

---

## Sparse Checkout

- Clone only subfolders.
- Useful for very large repos.

---

## Git LFS

- Stores large binaries separately.
- Keeps repo small.

---

## Cleaning History

Tools:
- git-filter-repo
- BFG

- Remove secrets.
- Delete folders from old commits.

---

## Submodules vs Subtrees

- Submodules fragile.
- Subtrees more Git-native.

---

## Enforcement at Scale

- commit linting
- server hooks
- security bots
- branch protections

---

## GitOps

- Infrastructure stored in Git.
- Tools:
  - Argo CD
  - Flux
- Git changes deploy clusters.
