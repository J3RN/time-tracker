server 'carp.j3rn.com', user: 'j3rn', roles: %w[app db web]

set :application, 'timesheet-staging'
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
