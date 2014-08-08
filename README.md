##Event Registration application

[ ![Codeship Status for hdfelix/ypw-reg](https://www.codeship.io/projects/a401b450-f996-0131-e120-6a9599d1e39b/status)](https://www.codeship.io/projects/28912)

Repo: https://bitbucket.org/hdfelix/ypw-reg

This is an event registration management site. You can use this site to manage registrations short one-day events that require
no hospitality accomodations as well as multi-day events where hospitality accomodations are necessary.  
   
###Features
* Create and manage events
* Create and manage event locations
* Create and manage hospitality locations
* Create and manage different types of users
* Reports and graphs for all of the data types
* ...

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
...
* (instructions on using the different parts of the site)
* (Themes)

## Constants
* US States - Location::STATE_LIST
* Event Types - Event::EVENT_TYPE
* User Types - User::USER_TYPE
* Hospitality TYpes - Hospitality::HOSPITALITY_TYPE
* Payment Types - Registration::PAYMENT_TYPE

[Finish]
