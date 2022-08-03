# frozen_string_literal: true

class Phone < ApplicationRecord
  belongs_to :user
  validates :phone, presence: true, uniqueness: true
  validates :country, presence: true
  validate :valid_phone
  validates_format_of :phone, with: /\d[0-9]\)*\z/, message: 'Only positive number without spaces are allowed'

  def valid_phone
    errors.add(:phone, 'format not supported for chosen coutry') unless TelephoneNumber.parse(phone,
                                                                                              country).valid?
  end
end
