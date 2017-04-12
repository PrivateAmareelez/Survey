class Poll < ApplicationRecord
  validates_presence_of :title
  validates_inclusion_of :active, in: [true, false]

  has_many :questions
  has_many :replies
  has_one :secret_code

  accepts_nested_attributes_for :secret_code
end
