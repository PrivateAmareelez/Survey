class RepliesController < ApplicationController
  before_action :set_poll, only: [:new, :create]

  def new
    @reply = @poll.replies.build
    @poll.questions.each { |question| @reply.answers.build question: question }
  end

  def create
    @reply = @poll.replies.build(reply_params)
    @ip = @reply.build_ip value: request.remote_ip, poll_id: @poll.id

    respond_to do |format|
      if @reply.save
        format.html do
          flash[:success] = 'Спасибо за Ваш голос !'
          render 'replies/finish'
        end
      else
        format.html { render :new }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  def finish
  end

  private
  def reply_params
    params.require(:reply).permit(answers_attributes: [:value, :question_id, :possible_answer_id])
  end

  def set_poll
    @poll = Poll.find(params[:poll_id])
  end
end