class PossibleAnswer < ApplicationRecord
  belongs_to :question, optional: true
end
