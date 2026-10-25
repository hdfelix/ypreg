You are helping plan a GitHub issue for the YPReg project (Rails event-registration app) before any code is written.

The user has provided the following description of the issue or feature:

$ARGUMENTS

## Step 1 — Understand the issue

If the description is unclear or missing key details, ask focused questions:
- What is the observed behavior vs. the expected behavior?
- Which model/controller/view/policy is involved? Which user role (admin, locality contact, attendee)?
- Is this a bug, UI fix, feature, refactor, or dependency/upgrade task?
- Are there screenshots, stack traces, or log excerpts?

If the description is clear enough, proceed directly to Step 2. Read the relevant code (`app/models`, `app/controllers`, `app/policies`, `app/views`, `config/routes.rb`, `db/schema.rb`, `spec/`) so the plan names real files and methods.

## Step 2 — Draft the plan

Produce a structured plan in this format:

---
**Title:** [Short imperative phrase, ≤ 60 chars]

**Type:** Bug | UI Fix | Feature | Refactor | Upgrade

**Summary:**
One or two sentences describing the problem and its impact.

**Location:**
- File: `app/models/foo.rb` (line ~N)
- File: `app/views/events/foo.html.haml` (line ~N)

**Root Cause:**
What is actually wrong or missing.

**Proposed Fix:**
Step-by-step description of what needs to change. Be specific — name models, actions, Pundit policy methods, routes, partials, migrations.

**Rails checklist** (include only the items that apply):
- Migration needed? (reversible, indexes on new foreign keys, regenerate `db/schema.rb`)
- Pundit: new/changed policy method and `authorize` call in the controller
- Strong params updated
- Routes (`config/routes.rb`) — note the nested `events/...` controllers
- Specs to add/update: model, policy, controller, feature (`spec/features/`)
- Gem/Ruby version impact (see `Gemfile`, `.ruby-version`)

**Acceptance Criteria:**
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Specs pass (`bundle exec rspec`) and `bundle exec rubocop` is clean for touched files
---

## Step 3 — Pick a label

| Type | Label |
|---|---|
| Bug | `bug` |
| UI Fix | `bug` (or `enhancement` if purely cosmetic) |
| Feature | `enhancement` |
| Refactor | `refactor` |
| Upgrade | `dependencies` |

`refactor` does not exist in the repo yet — if it is chosen, create it first:
`gh label create refactor --color 5319e7 --repo hdfelix/ypreg`

## Step 4 — Confirm with the user

Present the plan and suggested label together and ask: "Does this look right, or do you want to adjust anything (including the label) before I create the ticket?"

Do NOT create the GitHub issue until the user confirms.

## Step 5 — Create the GitHub issue

Once the user confirms, run:

```
gh issue create \
  --title "<title>" \
  --body "<full plan body in markdown>" \
  --label "<label>" \
  --repo hdfelix/ypreg
```

Report the issue number and URL back to the user.

Note: the repo currently has no milestones. Version milestones are created at release time by `/prepare-to-deploy`; do not assign one here.
