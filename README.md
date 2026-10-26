##Event Registration application


Repo: https://github.com/hdfelix/ypreg.git

<!-- coverage-badge -->![coverage](https://img.shields.io/badge/coverage-80.4%25-yellow)<!-- /coverage-badge -->

This is an event registration management site. You can use this site to manage registrations short one-day events that require
no hospitality accomodations as well as multi-day events where hospitality accomodations are necessary.  
   
It is currently running on: 
* Ruby 3.4
* Rails 8.1

### Features
* Create and manage events
* Create and manage event locations
* Create and manage hospitality locations
* Create and manage different types of users

## Quick start
Requires Ruby 3.4 and PostgreSQL.

```bash
$ make up        # start Postgres, prepare the DB, run Rails, print the URL (PORT=3100 by default)
$ make test      # run the spec suite
$ make coverage  # run the suite and refresh the coverage badge
$ make help      # list every target
```

Port 3000 busy? Pass another: `make up PORT=3200`. Stop the app with `make stop`.

Seeded login: `test@test.com` / `devaccount`. To create your own admin instead, run `rails ypreg:create_admin`.
