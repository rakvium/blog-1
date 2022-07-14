# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 require 'faker'

 
   User.create(user_name: 'Emanuel', password: 'mariam', email: "admin@admin.ad", role: 2)
   categories = Category.create([{ name: 'random' }, { name: 'art' }, { name: 'history' }])

  

   (1..20).each do |id|
       User.create!(
           user_name: Faker::Lorem.sentence(word_count: 1),
           email: Faker::Internet.email,
           role:0,
           password: 'mariam'
       )
   end

   
