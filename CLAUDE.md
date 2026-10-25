# YPReg

Rails event-registration app with hospitality (lodging) assignment. Being resurrected from 2022 —
Rails 8.1 / Ruby 3.4 (ported from 5.2/2.6 — see docs/resurrection.md), Postgres, HAML, Sprockets, Devise + Pundit, RSpec.

## Docs
- [Architecture](docs/architecture.md) — MVC layout, domain model, routes
- [Engineering standards](docs/engineering-standards.md) — Ruby/Rails conventions, clean code, SOLID
- [Testing](docs/testing.md) — TDD workflow, spec layout, commands
- [Resurrection](docs/resurrection.md) — fresh-app port plan (epic #63)
- [ROADMAP.md](ROADMAP.md) — historical version notes

## Non-negotiables
1. **Test first.** Red → green → refactor. No behavior change without a failing spec first.
2. **MVC with thin controllers.** Logic lives in models (or a plain Ruby object under `app/services`
   when it spans models); controllers only authenticate, authorize, delegate, and respond.
3. **Authorize everything.** Every action calls Pundit `authorize`; index actions use `policy_scope`.
4. **Small, single-purpose units.** Methods ≲ 10 lines, classes with one reason to change.
5. **Match surrounding code.** Follow `.rubocop.yml`; don't reformat unrelated code.

## Token discipline (always)
Before each task, pick the cheapest approach that is still correct, and the cheapest adequate model
(Sonnet for mechanical porting/edits/boilerplate; Opus only for design, tricky debugging, security).
- Read only what's needed: `grep`/line ranges over whole files; no directory sweeps.
- Trim command output (`| tail -40`, `rspec --only-failures`); never dump logs or full diffs.
- No subagents unless the task is genuinely broad; don't re-derive facts already established.
- Batch independent tool calls; make one edit per file where possible.
- Short replies: the result and the next decision, not a recap.

## Commands
```bash
bundle exec rspec path/to/spec.rb      # prefer targeted runs
timeout 600 bundle exec rspec          # full suite — check `free -h` first; never run in parallel
bundle exec rubocop <changed files>
bin/rails db:migrate                   # then commit the regenerated db/schema.rb
```

## Workflow
`/plan-ticket` → implement test-first on a branch → PR → `/prepare-to-deploy` (tags + release) →
`/save-state` at end of session. GitHub: `hdfelix/ypreg`. Deploy target: Heroku (user runs the push).

## Gotchas
- Secrets via Figaro `config/application.yml` (untracked); never commit it.
- `ApplicationController` and `Event` are the largest files — extract rather than grow them.
- `erd.pdf`, `models.*`, `results.xml` are generated artifacts; don't hand-edit.
