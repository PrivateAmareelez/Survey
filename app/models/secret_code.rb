class SecretCode < ApplicationRecord
  belongs_to :poll, optional: true

  validates_presence_of :value
end
