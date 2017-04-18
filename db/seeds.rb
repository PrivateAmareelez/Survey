# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@poll = Poll.create [{ title: 'TestPoll', active: false }]
@secret_code = SecretCode.create [{ value: 'testpoll', poll_id: Poll.last.id }]
20.times do
  @question_2 = Question.create [{ title: "What do you like the most ?", kind: 'choice', poll_id: Poll.last.id }]
  20.times { @possible_answer_2_1 = PossibleAnswer.create [{ title: "Apple", question_id: Question.last.id }] }
end

1000.times do
  @reply = Reply.create [{ poll_id: Poll.last.id, answers_attributes: [{ possible_answer_id: 1, question_id: Question.last.id }] }]
  @ip = Ip.create [{ reply_id: Reply.last.id, poll_id: Poll.last.id, value: '127.0.0.1' }]
end
@admin = User.create [{ email: 'test@test.com', password: 'qwerty', admin: true }]

