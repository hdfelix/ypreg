Prepare the YPReg project for a production deploy by tagging the release and creating a GitHub release.

Deploy target is Heroku (`Procfile`, `rails_12factor`, `Aptfile`; staging host `ypreg-staging.herokuapp.com`). Verify the git remotes with `git remote -v` — if no Heroku remote exists, tell the user the remote needs to be set up before the deploy step.

## Step 1 — Gather context

Run these in parallel:
```
git status --porcelain
git branch --show-current
git tag --sort=-version:refname | head -5
git log --oneline $(git describe --tags --abbrev=0 --match 'v*' 2>/dev/null)..HEAD
git remote -v
```

- Working tree must be clean and on `master`. If not, stop and tell the user.
- The latest `v*` tag is the **last deployed version**. If there are no tags yet (first release), use the full history and suggest `v0.1.0`; mention `ROADMAP.md` lists historical versions up to ~v0.13 that were never tagged.
- There is no in-code version file; the git tag is the source of truth.

## Step 2 — Recommend a version bump

Summarize the commits since the last tag in 2–3 bullets (ignore pure Dependabot merges in the narrative, but count them) and apply semver:

| Change type | Bump |
|---|---|
| Breaking change, Rails/Ruby major upgrade, destructive migration | **major** (x.0.0) |
| New feature, new model/table/route, new user-facing section | **minor** (x.y.0) |
| Bug fix, copy/style tweak, dependency bump | **patch** (x.y.z) |

State the recommendation (e.g. "I recommend a **minor** bump: v0.13.0 → v0.14.0") and ask: "Does this version look right, or would you like a different bump?"

Wait for the user to confirm before proceeding.

## Step 2.5 — Pre-deploy gate

Check resources first (`free -h && top -bn1 | head -5`); if memory > 80% or load exceeds CPU count, warn and ask before running the suite. Run sequentially, with timeouts:

```bash
timeout 600 bundle exec rspec
bundle exec rubocop
timeout 120 bundle exec rails_best_practices .
```
(`bundle exec rubocop` / `rails_best_practices` are advisory — report findings, do not block on style alone. Failing specs DO block.)

Security audit of the diff since the last tag:

```bash
git diff $(git describe --tags --abbrev=0 --match 'v*' 2>/dev/null)..HEAD -- app config lib db Gemfile Gemfile.lock
```

Work through this checklist:

**Rails**
- Every controller action calls `authorize` (Pundit) and index actions use `policy_scope`; no `skip_authorization` without a reason
- Strong params: no `permit!`, no new attributes permitted that grant privilege (e.g. role/admin flags on `User`)
- No SQL string interpolation in `where`/`order`/`find_by_sql`/`pg_search` scopes — use bind params
- No `html_safe` / `raw` / `<%== %>` / HAML `!=` on user-supplied data
- No `eval`, `system`, backticks, `send`/`constantize` on user input
- `redirect_to` never uses unvalidated params
- CSRF protection not disabled (`protect_from_forgery` intact); no new `skip_before_action :authenticate_user!` without justification
- Devise config unchanged or intentionally changed (`config/initializers/devise.rb`); confirmable/password flows intact
- CarrierWave uploaders (`app/uploaders`) restrict `extension_whitelist` and content types
- No hardcoded secrets — credentials come from Figaro `config/application.yml` / ENV (never committed; only `application.example.yml` is tracked)
- `config.force_ssl` on in production/staging

**Migrations**
- Reversible; no data loss without an explicit backup note; new foreign keys indexed; `db/schema.rb` committed and matches
- Migration run order on deploy noted in release notes

**Dependencies**
- `bundle audit check --update` if `bundler-audit` is available (Rails 5.2.1 / Ruby 2.6.5 are EOL — list known advisories under Known Issues rather than blocking, unless this release is the upgrade)

**Gate:**
- CRITICAL / HIGH findings or failing specs: **stop the deploy** — fix and re-run `/prepare-to-deploy`
- MEDIUM findings: fix or document as a known issue in the release notes
- LOW / INFO: note in the release notes only

State the result ("Pre-deploy gate: specs green, no findings" or a summary) before proceeding.

## Step 3 — Create the annotated tag

```
git tag -a v<version> -m "Version <version>"
git push origin v<version>
```

(There is no version file to bump, so there is no bump commit.)

## Step 4 — Create the GitHub release

Build release notes from the commits since the previous tag. Group them:

- **Features** — new capabilities
- **Improvements** — enhancements to existing features
- **Bug fixes** — correctness fixes
- **Dependencies** — Dependabot / gem bumps (one line, with count)
- **Migrations** — list any new files in `db/migrate/`, or "none"

Then run:
```
gh release create v<version> \
  --repo hdfelix/ypreg \
  --title "v<version>" \
  --notes "$(cat <<'NOTES'
## What's changed

### Features
- ...

### Improvements
- ...

### Bug fixes
- ...

### Dependencies
- ...

### Migrations
- ...

**Full changelog:** https://github.com/hdfelix/ypreg/compare/v<prev>...v<version>
NOTES
)"
```
For a first release, omit the compare link.

## Step 5 — Milestone and epic cleanup

The repo has no standing milestones, so this is lightweight:

1. Create the version milestone:
   ```
   gh api repos/hdfelix/ypreg/milestones --method POST -f title="v<version>" -f description="Released v<version>"
   ```
2. Find issues closed since the previous tag's date and attach them:
   ```
   gh issue list --repo hdfelix/ypreg --state closed --search "closed:>=<prev-tag-date>" --json number,title,milestone
   gh issue edit <n> --milestone "v<version>" --repo hdfelix/ypreg
   ```
   Skip issues that already have a version milestone.
3. Any open issue titled `Epic: ...` whose `- [ ] #N` children are all closed (and each has a merged PR) → close with a summary comment. Leave epics with open children alone and mention them in the report.

State how many issues were moved and how many epics closed.

## Step 6 — Report back and deploy

Tell the user:
- The tag created (`v<version>`) and the GitHub release URL
- Whether migrations are pending

Deploy is run by the user in their own terminal (it pushes to production). Give them the commands, adapted to the actual remote name from Step 1:

```bash
git push heroku master
heroku run rails db:migrate --app <app>     # only if the release has migrations
heroku releases --app <app> | head -3        # confirm the release landed
```

Do NOT run the push or migration yourself without explicit instruction.
