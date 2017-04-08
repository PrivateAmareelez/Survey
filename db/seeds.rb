# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@poll = Poll.create [{ title: 'TestPoll' }]
@question_1 = Question.create [{ title: "What's your name ?", kind: 'open', poll_id: Poll.last.id }]
@question_2 = Question.create [{ title: "What do you like the most ?", kind: 'choice', poll_id: Poll.last.id }]
@possible_answer_2_1 = PossibleAnswer.create [{ title: "Apple", question_id: Question.last.id }]
@possible_answer_2_2 = PossibleAnswer.create [{ title: "Orange", question_id: Question.last.id }]

