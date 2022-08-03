# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

User.create(user_name: 'Emanuel', password: 'mariam', email: 'admin@admin.ad', role: 2)

Article.create(title: Faker::Esport.player, body: Faker::Name.unique.name, description: Faker::Job.title, user_id: 2)
