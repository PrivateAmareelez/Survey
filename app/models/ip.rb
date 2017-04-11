class Ip < ApplicationRecord
  belongs_to :reply, optional: true

  validates_presence_of :value
end
