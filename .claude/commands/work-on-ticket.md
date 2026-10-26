You are starting work on a GitHub issue for the YPReg project (Rails event-registration app).

The ticket number (and optional hint) provided is: $ARGUMENTS

## Step 0 — Pick the cheapest correct approach and model

Before doing anything else, decide how to do this ticket with the fewest tokens that is still correct,
and say it in one line (approach + model). Follow the "Token discipline" rules in `CLAUDE.md`.

- **Model:** Sonnet for mechanical porting, edits, boilerplate, and well-specified tickets. Opus only for
  design, tricky debugging, or security work. If the ticket is already planned (`/plan-ticket`), it is
  almost always a Sonnet job.
- **Where to work:** do it inline by default. Spawn a sub-agent (`isolation: "worktree"`, `model: "sonnet"`)
  only when the work is genuinely broad or must not disturb the main working tree. Never run more than
  one test suite at a time, and never in parallel across sub-agents.
- **Reading:** `grep`/line ranges over whole files; no directory sweeps. Read only files the issue names.
- **Output:** trim command output (`| tail -40`, `rspec --only-failures`); never dump logs or full diffs.
- **Batching:** run independent tool calls together; make one edit per file where possible.

## Step 1 — Fetch the issue

```
gh issue view <issue-number> --repo hdfelix/ypreg
```

Read the title, summary, location, root cause, proposed fix, decisions, and acceptance criteria.
Summarize the scope in 2–3 sentences. If the issue is unplanned or ambiguous, stop and suggest
`/plan-ticket` rather than guessing.

If the issue's milestone is unset or `Backlog`, set it to the current release milestone:
```
gh issue edit <issue-number> --milestone "<current milestone>" --repo hdfelix/ypreg
```
List milestones with `gh api repos/hdfelix/ypreg/milestones --jq '.[].title'`. Leave an existing
version milestone alone.

## Step 2 — Create the branch

Name: `<issue-number>-short-description` (lowercase, hyphens, special characters stripped, ~40 chars max).
Always branch from `master`:
```
git checkout master && git pull origin master && git checkout -b <branch-name>
```

## Step 3 — Initial commit and push

```
git commit --allow-empty -m "Start work on #<issue-number>: <issue title> (#<issue-number>)"
git push -u origin <branch-name>
```

## Step 4 — Implement, test first

Follow `docs/engineering-standards.md` and `docs/testing.md`.

- **Red → green → refactor.** Write the failing spec before the change. No behavior change without one.
- Thin controllers, logic in models or `app/services`, Pundit `authorize` on every action, methods ≲ 10 lines.
- Make focused commits. Every commit subject ends with the issue number in parens: `Fix thing (#<issue-number>)`.
- Match surrounding code and `.rubocop.yml`; do not reformat unrelated code.
- Database changes: `bin/rails db:migrate`, then commit the regenerated `db/schema.rb`.
- Never commit `config/application.yml` or hand-edit generated artifacts (`erd.pdf`, `models.*`, `results.xml`).

**Resource check before any test run:** `free -h && top -bn1 | head -5`. If memory is above 80% or load
exceeds the CPU count, warn the user and ask before proceeding. Prefer targeted runs:
```
bundle exec rspec path/to/spec.rb
timeout 600 bundle exec rspec        # full suite, sequential only, before the PR
bundle exec rubocop <changed files>
```
If a timeout kills a run, report it and run smaller batches.

## Step 4.5 — Security audit (pre-PR gate)

Review the branch diff before opening the PR:
```
git diff master...HEAD -- app config lib db
```

- Every controller action calls `authorize`; index actions use `policy_scope`
- Strong params: no `permit!`, no new attributes permitted without need (watch role/admin flags)
- No raw SQL with interpolated input — use bind params or `sanitize_sql*`
- No `html_safe`/`raw` on user input; HAML output left escaped
- No `eval`, `system`, backticks, `send` with user input, or unsafe `constantize`
- No hardcoded credentials or secrets; nothing from `config/application.yml` committed
- Redirects use paths or `url_from`, never raw user-supplied URLs
- New gems checked with `bundle exec bundle-audit check` (already in CI)

Severity gate:
- CRITICAL / HIGH: fix before opening the PR
- MEDIUM: fix if straightforward, otherwise list under `## Security notes` in the PR
- LOW / INFO: note in the PR description only

If clean, state "Security audit: no findings."

## Step 5 — Open the PR

When every acceptance criterion is met, the suite passes, and rubocop is clean for touched files:

```
gh pr create --repo hdfelix/ypreg --base master --title "<issue title>" --body "$(cat <<'EOF'
## Summary
<bullet points of what changed>

## Fixes
Closes #<issue-number>

## Test plan
- [ ] `bundle exec rspec` passes
- [ ] `bundle exec rubocop` clean for touched files
- [ ] All acceptance criteria from the issue are met

## Security audit
<findings from Step 4.5, or "No findings.">
EOF
)"
```

Report the PR URL. Deploys are a separate step (`/prepare-to-deploy`); the user runs the Heroku push.
