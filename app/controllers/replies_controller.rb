class RepliesController < ApplicationController
  def new
    @poll = Poll.find(params[:poll_id])
    @reply = @poll.replies.build

    @poll.questions.each { |question| @reply.answers.build question: question }
  end

  def create
    @poll = Poll.find(params[:poll_id])
    @reply = @poll.replies.build(reply_params)
    var = @reply.errors.full_messages
    respond_to do |format|
      if @reply.save
        format.html do
          flash[:success] = 'Thank you for taking the poll.'
          render 'replies/finish'
        end
      else
        format.html { render :new }
      end
    end
  end

  def finish
  end

  private
  def reply_params
    params.require(:reply).permit(answers_attributes: [:value, :question_id, :possible_answer_id])
  end
end