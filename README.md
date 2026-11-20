# template-monorepo

The starter for new TypeScript monorepos: Bun workspaces and Turborepo, with every rule from [`@interest-protocol/standards`](https://github.com/josemvcerqueira/standards) enforced. On GitHub press **Use this template**, then rename `template-monorepo` in `package.json` and `AGENTS.md`. The root installs the standard once at a pinned tag; bump the tag to get rule updates, never copy rules into this repo.

```sh
bun install
bun run dev            # every app's dev task (apps/api: GET /health on PORT)
bun run gate           # the merge check, on workspaces changed since main
GATE_ALL=1 bun run gate
```

Included: `apps/api` (a service with the `src/platform` layer) and `packages/core` (a shared package with `exports`). Boundaries that fail the build: a package depending on an app, deep imports into another workspace, `../` across workspaces, a feature importing another feature, raw `fetch`/timers/`Date`/`console` outside `src/platform`. Each workspace extends the shared Oxlint preset and tsconfig; `ip-standards-verify` fails if any of them weakens it.

After the first push, make the gate required on `main` (needs repo admin):

```sh
gh api -X POST repos/OWNER/REPO/rulesets --input .github/ruleset.json
```
