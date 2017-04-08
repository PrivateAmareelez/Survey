class Answer < ApplicationRecord
  belongs_to :reply, optional: true
  belongs_to :question
  belongs_to :possible_answer, optional: true
end
