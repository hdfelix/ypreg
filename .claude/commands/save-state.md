# Save State

You are saving the current session state so a new conversation can pick up where this one left off.

## Step 1: Gather Current State

```bash
# Git state
git branch --show-current
git status --porcelain
git log --oneline -5
git worktree list
git tag --sort=-version:refname | head -1

# Local branches other than master
git branch --list | grep -v '^\*\|master' | sed 's/^  //'

# Unpushed commits on the current branch
git log --oneline @{u}..HEAD 2>/dev/null
```

Also read:
- `/home/hdfelix/.claude/projects/-home-hdfelix-code-ypreg/memory/MEMORY.md` (the index) and any memory files it points at that relate to in-progress work
- `ROADMAP.md` — only if the session touched roadmap items
- Any plan files in `.claude/plans/`

## Step 2: Fetch GitHub Issue AND PR States

Extract every `#NNN` referenced in the memory files, then batch-fetch state. Issues and PRs share one number space on GitHub; `gh issue view` works for both, and the `pull_request`-style fields come from `gh pr view`.

```bash
# Open items overview
gh issue list --repo hdfelix/ypreg --state open --json number,title,labels,updatedAt
gh pr list --repo hdfelix/ypreg --state open --json number,title,headRefName,isDraft,updatedAt

# Each referenced number (try as PR first, fall back to issue)
gh pr view <N> --repo hdfelix/ypreg --json number,state,mergedAt,title,updatedAt 2>/dev/null \
  || gh issue view <N> --repo hdfelix/ypreg --json number,state,closedAt,title,updatedAt
```

Check ALL referenced numbers — stale statuses are the most common source of incorrect state. Note that this repo gets frequent Dependabot PRs; summarize them as a count rather than listing each one.

Identify:
- **Closed > 7 days ago** → candidates for pruning from memory
- **Closed ≤ 7 days ago** → keep briefly, marked closed
- **PRs now merged** → fix any text saying "PR #NNN open"
- **Still open** → keep, update status if changed

## Step 3: Update Memory

Update the memory files under `/home/hdfelix/.claude/projects/-home-hdfelix-code-ypreg/memory/` following the standard memory format (one fact per file with frontmatter; one-line pointer per file in `MEMORY.md`). Update an existing file rather than creating a duplicate. Maintain a single `project` memory named `current-work` containing:

- **Version Status** — latest git tag (or "untagged"), Ruby/Rails versions from `.ruby-version` / `Gemfile`
- **Resurrection progress** — what has been done toward getting the app running again (Ruby/Rails upgrade, DB setup, spec status) and the next concrete step
- **Current Work** — active branches, linked issues/PRs, and status (in progress, ready for review, blocked)
- **Recently Merged** — PRs merged in the last ~2 weeks (verified via `gh`, not copied from the previous save)
- **Known issues / blockers** — failing specs, EOL dependencies, missing credentials

Do not store anything derivable from code or git history. Keep `MEMORY.md` under 200 lines. Remove entries for work that is merged AND whose issues are closed.

## Step 4: Check Plan Files

For each file in `.claude/plans/` (if the directory exists):
- **Completed and merged** → note it can be deleted (do not delete without asking)
- **In progress** → ensure it reflects current state
- **Stale/abandoned** → flag for the user

## Step 5: Print Summary Report

```
## Session State Saved

### Memory Updated
- ✓ current-work — [brief description of changes]
- ✓ MEMORY.md — [index changes]

### Issues / PRs
- Pruned (closed > 7 days): #NNN, #NNN
- Updated: #NNN (now closed), #NNN (status changed)
- Still active: #NNN, #NNN
- Dependabot PRs open: N

### Active Work Captured
- Branch: `branch-name` — status description

### Plan Files
- `plan-file.md` — [current / stale / can be removed]

### Warnings
- ⚠ Uncommitted changes in: file1, file2
- ⚠ Unpushed commits on branch: branch-name
- ⚠ MEMORY.md is [N] lines (target: under 200)
```

Omit Warnings if there are none.

## Important Notes

- Do NOT modify `CLAUDE.md` or other stable project instructions
- Do NOT commit anything — this is a state-saving operation only
- Be concise; when in doubt about removing content, keep it and note the uncertainty in the report
- If the global MCP registry has ⚠️/🔴 findings, include them under "Pending actions" in the report so staleness survives the session boundary
