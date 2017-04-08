class Reply < ApplicationRecord
  belongs_to :poll, optional: true

  has_many :answers

  accepts_nested_attributes_for :answers
end
