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


# commands used to setup db

$ rails g model Person name:string

$ rails g model Movie title:string

$ rails g model TV name:string

$ rails g model MovieRole person_id:int movie_id:int department:string character:string job:string

$ rails g model TVRole person_id:int movie_id:int department:string character:string job:string

$ rake db:migrate


# scripts

* crawl movie by id
$ rails runner lib/crawl_movie.rb [id1,[id2, .. ] ]

* crawl tv by id
$ rails runner lib/crawl_tv.rb [id1,[id2, .. ] ]

* crawl entire movie
$ rails runner lib/crawl_entire_movie.rb

* crawl entire tv
$ rails runner lib/crawl_entire_movie.rb

* crawl entire person
$ rails runner lib/crawl_entire_movie.rb

* initialize db with TMDb crawler
$ rails db:reset