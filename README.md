##Event Registration application

[ ![Codeship Status for
hdfelix/ypreg](https://codeship.com/projects/c65ff3a0-7a8e-0132-7773-2e5924fc2807/status?branch=master)](https://codeship.com/projects/56162)

Repo: https://github.com/hdfelix/ypreg.git

This is an event registration management site. You can use this site to manage registrations short one-day events that require
no hospitality accomodations as well as multi-day events where hospitality accomodations are necessary.  
   
It is currently running on: 
* Ruby 2.5.1
* Rails 5.2.0

### Features
* Create and manage events
* Create and manage event locations
* Create and manage hospitality locations
* Create and manage different types of users

## Setup
To get started, clone this repo and run:

```bash
$ bundle
```
The site is configured to use PostgreSQL for all environments (Development|Test|Production). Make sure you install and configure PostgreSQL before running the following commands from your terminal:

```bash
$ rails db:create
$ rails db:migrate
```

Next, Run the following command to create an admin user account:  

```bash
$ rails ypreg:create_admin
```

### Test data
The previous instructions will get you a clean database. If you prefer to see the app with some test data, run the following:

```bash
$ rails db:setup
```

Then you can log in using `test@test.com` and password: `devaccount`.
