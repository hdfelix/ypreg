##Event Registration application

[ ![Codeship Status for
hdfelix/ypreg](https://codeship.com/projects/c65ff3a0-7a8e-0132-7773-2e5924fc2807/status?branch=master)](https://codeship.com/projects/56162)

Repo: https://github.com/hdfelix/ypreg.git

This is an event registration management site. You can use this site to manage registrations short one-day events that require
no hospitality accomodations as well as multi-day events where hospitality accomodations are necessary.  
   
###Features
* Create and manage events
* Create and manage event locations
* Create and manage hospitality locations
* Create and manage different types of users

## Setup
To get started, clone this repo and run:
```
$ bundle
```
The site is configured to use PostgreSQL for all environments (Development|Test|Production). Make sure you install and configure PostgreSQL before running the following commands from your terminal:
```
$ rake db:create
$ rake db:migrate
```

Next, Run the following command to create an admin user account:  
```
rake ypreg:create_admin
```
