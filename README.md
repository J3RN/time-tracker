# Time Tracker

![Travis CI badge](https://travis-ci.org/J3RN/timesheet.svg)

This is an application that I wrote long ago, but have since repurposed to play a critical role as my To-Do List and time tracker. I have found it to be exceptionally useful, and I hope you will as well.

## Prerequisites

- Ruby v2.3.0. If you do not have Ruby installed, I would recommend [installing it through RVM](http://rvm.io/rvm/install).
- PostgreSQL. If you are on a Mac, I recommend [Postgres.app](http://postgresapp.com/). If you are another system, God save you.

## Setup

1. Clone this repository
```
git clone git@github.com:J3RN/timesheet.git
```

2. Enter the directory
```
cd timesheet
```

3. Pull the dependencies. This may take a while if this is the first Rails app you've worked with.
```
bundle
```

4. Setup the database
```
rake db:setup
```

5. Start the server
```
bundle exec passenger start
```

## TODO
- Security audit. I'm none too confident in my user authorization (NOTE: NOT USER AUTHENTICATION. Your passwords are safe).
- `dependent: :destroy` relations
- Testing. This has been largely neglected, and really ought to be implemented.
- Redo the UI with [Ember.js](http://emberjs.com)
