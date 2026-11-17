# Git Branching Strategy

How we name, create, merge and clean up branches in this repository.

---

## 1. Branch types

| Branch | Pattern | Created from | Merges into | Lifetime |
|---|---|---|---|---|
| Production | `main` | — | — | Permanent |
| Development | `development/vX_Y_Z_YYYYMMDDHHmm` | `main` | `main` | Until the version is released |
| Feature | `features/<dev-version>/<TICKET>-<short-desc>` | its `development/` branch | the same `development/` branch | Until the PR is merged |
| Hotfix | `hotfix/vX_Y_Z_YYYYMMDDHHmm` | `main` | `main`, then synced to active `development/` branches | Until merged |

```
main ─────●──────────────────────────────●─────────────●──────────►
          │                              ▲  (v0.0.1)   ▲  (v0.0.2)
          │                              │             │
          │                              │     hotfix/v0_0_2_202612051000
          ▼                              │
development/v0_0_1_202611170000 ──●──●───┘
          │                       ▲  ▲
          │                       │  │
          ├── features/v0_0_1_202611170000/SFASACR-1234-target-achievement
          └── features/v0_0_1_202611170000/SFASACR-1250-order-sync
```

---

## 2. Naming rules

### Version format: `vX_Y_Z_YYYYMMDDHHmm`

Branch names use **underscores (`_`)**, not dots.

| Part | Meaning | Example |
|---|---|---|
| `X` | Major: big release or breaking change | `0` |
| `Y` | Minor: new features or CR | `0` |
| `Z` | Patch: bug fixes or hotfix | `1` |
| `YYYYMMDDHHmm` | When the branch was created | `202611170000` = 17 Nov 2026, 00:00 |

Example: `development/v0_0_1_202611170000`

### Feature format

```
features/<dev-version>/<TICKET-ID>-<short-desc>
```

- `<dev-version>` is the exact version part of the parent development branch.
- `<short-desc>` is 2–5 words, lowercase, separated by hyphens.
- No spaces or special characters.

Example: `features/v0_0_1_202611170000/SFASACR-1234-target-achievement`

### Good vs bad

| ✅ Good | ❌ Bad |
|---|---|
| `development/v0_1_0_202612011000` | `dev_new`, `Development/V1`, `development/v0.1.0` |
| `features/v0_0_1_202611170000/SFASACR-1234-target-achievement` | `features/target achievement`, `feature1` |
| `hotfix/v0_0_2_202612051000` | `fix`, `hotfix-urgent` |

### Why features are not nested under `development/`

Git cannot have both of these branches, because a branch name cannot also be used as a folder:

```
development/v0_0_1_202611170000                      ← branch
development/v0_0_1_202611170000/SFASACR-1234-xyz     ← fails
```

That is why features use their own `features/` prefix.

---

## 3. Workflow

### A. Start a new version (development branch)

```bash
git checkout main
git pull
git checkout -b development/v0_1_0_$(date +%Y%m%d%H%M)
git push -u origin development/v0_1_0_202612011000
```

### B. Work on a feature

```bash
git checkout development/v0_0_1_202611170000
git pull
git checkout -b features/v0_0_1_202611170000/SFASACR-1234-target-achievement

# ...make changes...
git add <files>
git commit
git push -u origin features/v0_0_1_202611170000/SFASACR-1234-target-achievement
```

Then raise a PR into `development/v0_0_1_202611170000`.

### C. Keep a feature up to date

```bash
git checkout features/v0_0_1_202611170000/SFASACR-1234-target-achievement
git fetch origin
git merge origin/development/v0_0_1_202611170000
```

### D. Release to production

1. Finish QA on the `development/` branch.
2. Raise a PR from `development/v0_0_1_202611170000` into `main`.
3. Once it is approved and merged, tag the release:

```bash
git checkout main
git pull
git tag -a v0.0.1 -m "Release v0.0.1"
git push origin v0.0.1
```

> Release **tags** use dots (`v0.0.1`), the standard semantic version format. Only **branch names** use underscores.

4. Delete the merged feature branches (see section 8).

### E. Hotfix production

```bash
git checkout main
git pull
git checkout -b hotfix/v0_0_2_$(date +%Y%m%d%H%M)
# ...fix...
git push -u origin hotfix/v0_0_2_202612051000
```

1. Raise a PR from the hotfix branch into `main`. Once it is merged, tag it `v0.0.2`.
2. Merge `main` back into every active `development/` branch so the fix is not lost:

```bash
git checkout development/v0_1_0_202612011000
git pull
git merge main
git push
```

---

## 4. Merge rules

| From → To | Merge type | Approvals |
|---|---|---|
| `features/*` → `development/*` | Squash merge or merge commit | 1 reviewer |
| `development/*` → `main` | Merge commit (`--no-ff`) | 2 reviewers + QA sign-off |
| `hotfix/*` → `main` | Merge commit (`--no-ff`) | 1 reviewer + lead approval |
| `main` → `development/*` | Merge commit (sync) | No PR needed |

### Never

- Commit directly to `main`.
- Merge a feature branch directly into `main`.
- Create a feature branch from `main`.
- Merge one `development/` version into another without the lead agreeing.
- Force-push to `main` or `development/*`.

---

## 5. Commits

- Use the team commit format: Version / UserStoryID / Message / +Author.
- One logical change per commit.
- Commit only files related to the ticket. Do not include stray lock, IDE or generated files unless they are needed.

---

## 6. Pull requests

- **Title:** `SFASACR-1234: Short description of the change`
- **Description:** what changed, why, how it was tested, and screenshots for UI changes.
- **Before you raise it:**
  - `flutter analyze` is clean.
  - Tests pass.
  - The branch is up to date with its target branch.
- **Link:** the Linear or Jira ticket.

---

## 7. Branch protection (GitHub)

| Rule | `main` | `development/*` |
|---|---|---|
| Require a PR before merging | ✅ | ✅ |
| Required approvals | 2 | 1 |
| Block force push | ✅ | ✅ |
| Block deletion | ✅ | ✅ (while active) |
| Require status checks (build, analyze, tests) | ✅ | ✅ |
| Restrict who can merge | Leads only | Developers |

---

## 8. Cleanup

```bash
# Delete a merged feature branch, locally and on the remote
git branch -d features/v0_0_1_202611170000/SFASACR-1234-target-achievement
git push origin --delete features/v0_0_1_202611170000/SFASACR-1234-target-achievement

# Remove stale remote-tracking references
git fetch --prune

# List all feature branches for one version
git branch -a --list "*features/v0_0_1_202611170000/*"
```

---

## 9. Quick reference

| Task | Branch from | Branch name | PR into |
|---|---|---|---|
| New release cycle | `main` | `development/vX_Y_Z_<timestamp>` | `main` |
| New feature or bug fix | `development/…` | `features/<dev-version>/<TICKET>-<desc>` | the same `development/…` |
| Urgent production fix | `main` | `hotfix/vX_Y_Z_<timestamp>` | `main`, then sync into `development/…` |
| Release | — | tag `vX.Y.Z` on `main` | — |

Current active development branch: `development/v0_0_1_202611170000`
