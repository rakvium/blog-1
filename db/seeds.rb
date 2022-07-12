# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 require 'faker'

 
   User.create(user_name: 'Emanuel', password: 'mariam', email: "admin@admin.ad", role: 2)
   categories = Category.create([{ name: 'random' }, { name: 'art' }])

  

   (1..20).each do |id|
       User.create!(
           user_name: Faker::Lorem.sentence(word_count: 1),
           email: Faker::Internet.email,
           role:2,
           password: 'mariam'
       )
   end

   (1..5).each do |id|
    Comment.create!(
        body: Faker::Lorem.sentence(word_count: 1),
        user_id:2,
        article_id: 52,
        status:'public'
    )
end
