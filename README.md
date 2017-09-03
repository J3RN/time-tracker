# Time Tracker

[![Join the chat at https://gitter.im/J3RN/timesheet](https://badges.gitter.im/J3RN/timesheet.svg)](https://gitter.im/J3RN/timesheet?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Travis CI badge](https://travis-ci.org/J3RN/time-tracker.svg)](https://travis-ci.org/J3RN/time-tracker)

This is an application that I wrote long ago, but have since repurposed to play a critical role as my To-Do List and time tracker. I have found it to be exceptionally useful, and I hope you will as well.

## Prerequisites

- Ruby v2.3.0. If you do not have Ruby installed, I would recommend [installing it through RVM](http://rvm.io/rvm/install).
- PostgreSQL. If you are on a Mac, I recommend [Postgres.app](http://postgresapp.com/).

## Setup
1. Install the prerequisites

2. Clone this repository
  ```
  git clone https://github.com/J3RN/timesheet.git
  ```

3. Enter the directory
  ```
  cd timesheet
  ```

4. Pull the dependencies. This may take a while if this is the first Rails app you've worked with.
  ```
  bundle
  ```

5. Setup the database
  ```
  rake db:setup
  ```

6. Start the server
  ```
  bundle exec passenger start
  ```

## Testing

- Tests can be run using `rake test`
- For test coverage, run your tests, open up `coverage/index.html` in your browser
