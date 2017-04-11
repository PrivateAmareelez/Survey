class Question < ApplicationRecord
  belongs_to :poll, optional: true

  has_many :possible_answers
  has_many :answers

  validates_presence_of :kind, :title

  accepts_nested_attributes_for :possible_answers, reject_if: proc { |attributes| attributes['title'].blank? }

  def serialize_for_graph
    PollSerializer.answers_per_question(self).to_json
  end
end
