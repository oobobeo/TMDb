# README


# Versions

$ ruby -v
2.5.1p57

$ rails -v
6.0.0


# Overview

* 스크립트를 이용해 TMDb 의 데이터를 받아와 Person, Movie, TV의 데이터베이스(sqlite3) 에 저장함

* Views, Control 부분은 아직 만들지 못함


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

* update DB with changes (changes in the last 24h will be effected)

$ rails runner lib/updateDB.rb