# frozen_string_literal: true

class Place < ApplicationRecord
  belongs_to :user
  reverse_geocoded_by :latitude, :longitude, address: :name
  after_validation :reverse_geocode
  validates :name, presence: true
end
