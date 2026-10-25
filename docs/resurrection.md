# Resurrection Plan

Status: ported to Ruby 3.4.8 / Rails 8.1.4 on branch `rails-8-port` (uncommitted); suite green (435 examples, 0 failures, 18 pending as before); app runs locally. Epic: #63.

## Approach
Port into a fresh Rails 8.1 app instead of hopping 5.2 → 6.0 → 6.1 → 7.x → 8.1 (old Rubies don't build
against Fedora's OpenSSL 3, and Rails 5.2/6.0 can't run on Ruby 3.x). The ~430 existing examples are the safety net.

## Steps
1. **Toolchain** (#64, done) — system Ruby 3.4.8, Postgres, dnf deps. No old Rubies.
2. **Port** — `rails new` (Postgres), copy `app/`, `spec/`, `db/schema.rb`, needed `config/`; hand-port Gemfile.
3. **Green** — work failing specs to zero (assets, Devise, CarrierWave, Turbo, Bootstrap decision).
4. **Harden & release** — `bundle audit`, rubocop 1.x, GitHub Actions CI, README, first tag.

## Known blockers
- Git-pinned gems (`devise`, `shoulda-matchers`) and `pg ~>0.21` are dropped in the port.
- Heroku app/credentials status unknown.
- Do not expose the old app publicly (EOL, unpatched).

## Local setup (Fedora 42, done 2026-10-25, #64)
System Ruby 3.4.8 is used directly (no version manager); gems install per project via
`bundle config set path vendor/bundle`.
```bash
sudo dnf install -y ruby-devel libyaml-devel zlib-devel libpq-devel postgresql-server redhat-rpm-config
sudo postgresql-setup --initdb && sudo systemctl enable --now postgresql   # Postgres 16
sudo -u postgres createuser --superuser $USER                             # local dev only
gem install rails -v '~> 8.1.0' --no-document
```
Already present: gcc, make, openssl-devel, libffi-devel, ImageMagick, Google Chrome (chromedriver via selenium-manager).
Verified: throwaway `rails new --database=postgresql` booted on Rails 8.1.4 / Ruby 3.4.8 / PostgreSQL 16.13 and created its databases.

## Port notes
- Fresh Rails 8.1 scaffold files (`bin/`, `boot`, `puma`, envs) copied in; `app/`, `spec/`, `db/schema.rb` kept. `staging.rb` now requires `production.rb`.
- Assets: still Sprockets (`sprockets-rails`, `sass-rails` + `sassc-embedded` Dart Sass shim, `terser`); bootstrap-sass 3 retained. Moving to Propshaft/Turbo/current Bootstrap is optional follow-up work.
- Dropped: figaro (use ENV), spring, guard, coverband, undercover, skylight, webdrivers (selenium-manager), turbolinks, coffee-rails, uglifier, git-pinned gems, `secret_token.rb` (a committed `secret_key_base` — rotate it; production now reads `SECRET_KEY_BASE`).
- `database.yml` uses fixed names (`ypreg_development`, `ypreg_test`) and `DATABASE_URL` in staging/production.
- Spec fixes: FactoryBot block syntax + `use_parent_strategy = false`, `update_attributes` → `update`, `Pundit::Authorization`, headless Chrome driver, `database_cleaner-active_record`.
- Rubocop 1.x with a regenerated `.rubocop_todo.yml`; CI in `.github/workflows/ci.yml` (rspec, rubocop, bundle-audit).

## Run locally
```bash
bundle config set path vendor/bundle && bundle install
bin/rails db:create db:schema:load db:seed   # login: test@test.com / devaccount
bin/rails server -p 3100                      # port 3000 is used on this machine
```
