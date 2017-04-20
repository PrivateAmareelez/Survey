class PollSerializer
  def self.count_per_month poll
    replies = poll.replies.group_by { |reply| reply.created_at.beginning_of_month }

    data = replies.map { |key, values| values.length }

    {
        data: data,
        title: "Polls answered by month",
        x_axis: {
            legend: "Polls per month",
            series: replies.keys.map { |date| date.strftime "%b %Y" }
        },
        y_axis: {
            legend: "No. polls",
            scale: [0, (data.max || 0) + 1]
        }
    }
  end

  def self.answers_per_question question
    answers_per_question = question.answers.group_by(&:possible_answer)
    data = answers_per_question.map { |possible_answer, answers| answers.length }

    {
        data: data,
        title: %(#{question.title}),
        y_axis: {
            legend: "No. of answers",
            scale: [0, (data.max || 0) + 1]
        },
        x_axis: {
            legend: "Answers per question",
            series: answers_per_question.map do |possible_answer, answers|
              if !possible_answer.nil?
                possible_answer.title
              else
                ""
              end
            end
        }
    }
  end
end