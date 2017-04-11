class Ip < ApplicationRecord
  belongs_to :reply, optional: true
end
