# ChatLogger
A simple chat logging API built using Rails and postgreSQL. To run the server locally, clone this repo, run `bundle install`, and then run `rails s`.

The events controller supports GET requests to /events with these optional params:
- from (as YYYY-MM-DDTHH:MMZ)
- to (as YYYY-MM-DDTHH:MMZ)

The event controller also supports POST requests to /events, and expects these params:
- date (as YYYY-MM-DDTHH:MMZ)
- user
- type
- message (optional)
- otheruser (optional)

The summary controller supports GET requests to /summary with these optional params:
- from (as YYYY-MM-DDTHH:MMZ)
- to (as YYYY-MM-DDTHH:MMZ)
- by (one of "minute", "hour", "day")

## Tests
To run all the tests for this app, run `rspec spec`.
