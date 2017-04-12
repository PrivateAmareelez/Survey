class DeactivatePollJob < ApplicationJob
  queue_as :default

  def perform(poll)
    poll.active = false
    poll.save

    respond_to do |format|
      flash[:info] = 'Timer has stopped.'
      format.html { redirect_to poll }
      format.json { render :show, status: :ok, location: poll }
    end
  end
end
