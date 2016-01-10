# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Event.create(
  {"date": "2014-02-28T13:00Z", "user": "Alice", "type": "enter"},
  {"date":"2014-02-28T13:01Z", "user": "Alice", "type": "comment", "message": "hello, this is a sample message"},
  {"date": "2014-02-28T13:02Z", "user": "Alice", "type": "highfive", "otheruser": "Bob"},
  {"date": "2014-02-28T13:03Z", "user": "Alice", "type": "leave"})
