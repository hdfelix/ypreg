.DEFAULT_GOAL := help
PORT ?= 3100
PID  := tmp/pids/server.pid
URL  := http://localhost:$(PORT)

.PHONY: help up db-up setup server stop test coverage lint port-free

help: ## List available targets
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-10s %s\n", $$1, $$2}'

up: port-free db-up setup ## Start Postgres, prepare the DB, run Rails in the background, print the URL
	@bin/rails server -p $(PORT) -d
	@for i in $$(seq 1 30); do \
	  if curl -s -o /dev/null $(URL); then echo "App running at $(URL)  (stop with: make stop)"; exit 0; fi; sleep 1; \
	done; echo "Rails did not answer on $(URL); see log/development.log"; exit 1

db-up: ## Start PostgreSQL if it is not running
	@pg_isready -q || sudo systemctl start postgresql

setup: ## Install gems, prepare the DB, seed it when empty
	bundle config set path vendor/bundle
	bundle install
	bin/rails db:prepare
	bin/rails runner 'exit(User.exists? ? 0 : 1)' || bin/rails db:seed

server: port-free ## Run Rails in the foreground
	@echo "App running at $(URL)"
	@bin/rails server -p $(PORT)

stop: ## Stop the background Rails server
	@test -f $(PID) && kill $$(cat $(PID)) && echo "Stopped" || echo "Not running"

test: ## Run the full spec suite
	timeout 600 bundle exec rspec

coverage: ## Run the full suite and rewrite the README coverage badge
	timeout 600 bundle exec rspec
	bin/update-coverage-badge

lint: ## Run rubocop
	bundle exec rubocop

port-free:
	@if ss -ltn | grep -q ':$(PORT) '; then echo "Port $(PORT) is in use; try: make up PORT=3200"; exit 1; fi
