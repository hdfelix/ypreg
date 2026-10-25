# Engineering Standards

## Ruby / Rails conventions
- Follow the [Ruby Style Guide](https://rubystyle.guide) and [Rails Style Guide](https://rails.rubystyle.guide); `.rubocop.yml` is authoritative where they differ.
- Convention over configuration: RESTful resources and standard seven actions; add a nested resource before adding a custom action.
- Fat model, skinny controller — but don't let models become god objects (see SOLID below).
- Queries: scopes on models, `includes` to avoid N+1 (Bullet is installed in dev), no SQL string interpolation.
- Strong parameters in every controller; never `permit!`.
- Prefer `&.`, guard clauses, keyword args, and frozen string literals; no `unless/else`, no nested ternaries.
- No logic in views/helpers beyond formatting; use decorators for presentation.
- Migrations: reversible, indexed foreign keys, no model references inside them; commit `db/schema.rb`.
- Config via ENV/Figaro (twelve-factor); no secrets in code.

## Clean code
- Names reveal intent; methods do one thing at one level of abstraction.
- Small units (methods ≲ 10 lines, classes ≲ 100); extract when they grow.
- No dead code, no commented-out code, no speculative generality (YAGNI).
- Comments explain *why*, not *what*.
- DRY applies to knowledge, not to coincidental similarity — duplicate twice, abstract on the third.
- Law of Demeter: avoid `a.b.c.d` chains; delegate.

## SOLID (Ruby-flavored)
- **S**ingle responsibility — one reason to change. Extract service/query/form objects when a model or controller serves two masters.
- **O**pen/closed — extend via composition, polymorphism, or new policy/decorator classes rather than editing conditionals.
- **L**iskov — subclasses (e.g. policies inheriting `ApplicationPolicy`) honor the parent's contract.
- **I**nterface segregation — small, focused public APIs; keep helpers/concerns narrow.
- **D**ependency inversion — inject collaborators (constructor args) instead of hard-coding constants, so units are testable with doubles.

## Security baseline (OWASP)
Authorize every action, escape output (no `html_safe`/`raw` on user data), parameterize SQL, keep CSRF on,
restrict upload types, keep dependencies patched. `/prepare-to-deploy` enforces a checklist.

## Git / PRs
- Small branches, one concern each; imperative commit subjects; reference the issue (`Closes #N`).
- Don't mix refactors with behavior changes in one commit.
