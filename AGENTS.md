# template-monorepo

A Node 24 TypeScript monorepo (npm workspaces + Turborepo) built on the Interest Protocol house standard. Read `node_modules/@interest-protocol/standards/STANDARD.md` once; the lint rules enforce the rest and their messages tell you the fix.

## Layout

`apps/<name>` deployables · `packages/<name>` shared code. Apps may import packages; packages never import apps. Import a package only by its name (`@repo/core`), never its internals (`@repo/core/src/...`) and never with `../` across workspaces. Inside a workspace use `#folder/...` subpath imports (`#lib/cents`).

Inside each workspace the single-repo folders apply: `src/app` entry points · `src/features/<name>` one folder per feature · `src/platform` the only code that touches the runtime · `src/data` storage and external APIs · `src/config/env.ts` the parsed environment · `src/lib` pure helpers. A feature never imports another feature.

## Adding a workspace

Copy `packages/core` (or `apps/api`), rename it in `package.json`, keep its `.oxlintrc.json`, `tsconfig.json` and scripts as they are. A package must declare `exports`.

## Gate

`npm run gate` (standard check, oxfmt, turbo lint/typecheck/test on affected workspaces, knip) is the merge check; `GATE_ALL=1 npm run gate` runs every workspace. Hooks lint after every edit and will not let you finish while the gate fails. Lint, format, compiler, turbo, hook and CI config are read-only for agents: change the code, not the rules.

## Review

A different agent reviews every PR from the diff alone. A comment that comes up twice becomes a lint rule in `@interest-protocol/standards`.

## Not allowed without Jose

Secrets in the repo, deploys, branch-protection changes.
