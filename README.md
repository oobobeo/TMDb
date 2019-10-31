# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# commands

$ rails g model Person name:string department:string character:string job:string

$ rails g model Movie title:string

$ rails g model TV name:string

$ rails g migration CreateTVPersonsJoinTable tv person

$ rails g migration CreateMoviesPersonsJoinTable movie person

$ rake db:migrate