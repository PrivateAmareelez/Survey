class Poll < ApplicationRecord
  validates_presence_of :title

  has_many :questions
  has_many :replies
  has_one :secret_code

  accepts_nested_attributes_for :secret_code
end
