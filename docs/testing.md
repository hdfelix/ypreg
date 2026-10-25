# Testing (TDD)

## Cycle
1. **Red** — write the smallest failing spec that states the behavior.
2. **Green** — simplest code that passes.
3. **Refactor** — clean up with the suite green; commit.

Bug fixes start with a spec that reproduces the bug.

## Layout (`spec/`)
| Dir | Covers |
|---|---|
| `models` | validations, associations, scopes, domain logic — bulk of the tests |
| `policies` | Pundit permissions per role |
| `controllers` | authorization, redirects, params handling (thin) |
| `features` | Capybara end-to-end user flows (few, high value) |
| `decorators`, `helpers`, `views` | presentation |
| `factories` | FactoryBot factories (`spec/factories/factories.rb`; `factories_spec.rb` lints them) |

Tools: RSpec, FactoryBot, shoulda-matchers, Capybara + selenium, DatabaseCleaner, Timecop, SimpleCov.

## Rules
- Test behavior, not implementation; one logical assertion per example.
- Prefer FactoryBot over fixtures; build, don't create, when persistence isn't needed.
- Mock only at boundaries (external services, time via Timecop); not the object under test.
- Keep feature specs few; push logic down to model/policy specs.
- Deterministic: no order dependence, no sleeps.

## Running
```bash
free -h && top -bn1 | head -5            # check resources first
bundle exec rspec spec/models/event_spec.rb
timeout 600 bundle exec rspec            # full suite, sequential only
```

