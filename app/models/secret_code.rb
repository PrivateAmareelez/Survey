class SecretCode < ApplicationRecord
  belongs_to :poll, optional: true

end
