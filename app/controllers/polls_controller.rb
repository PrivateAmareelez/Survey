class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy, :stop, :run, :time_left]
  before_action :admin!

  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
  end

  # GET /polls/new
  def new
    @poll = Poll.new
    @poll.build_secret_code
  end

  # GET /polls/1/edit
  def edit
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)

    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    @poll.secret_code.destroy
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def run
    @poll.active = true
    @poll.save
    Delayed::Job.where(queue: "#{@poll.id}_queue").destroy_all
    Delayed::Job.enqueue(DeactivatePollJob.new(@poll), run_at: params[:minutes].to_f.minutes.from_now)

    respond_to do |format|
      format.html { redirect_to @poll, notice: "Timer for #{params[:minutes]} minutes has been launched." }
      format.json { render :show, status: :ok, location: @poll }
    end
  end

  def stop
    @poll.active = false
    @poll.save
    Delayed::Job.where(queue: "#{@poll.id}_queue").destroy_all

    respond_to do |format|
      flash[:info] = 'Timer has been stopped.'
      format.html { redirect_to @poll }
      format.json { render :show, status: :ok, location: @poll }
    end
  end

  # GET /time_left/1.json
  def time_left
    job = Delayed::Job.where(queue: "#{@poll.id}_queue")
    if job.empty?
      render json: [Time.at(job.run_at - Time.now).utc.strftime("%T"), (job.run_at - Time.now) / total_time * 100]
    else
      job = job.first
      total_time = job.run_at - job.created_at
      render json: [Time.at(job.run_at - Time.now).utc.strftime("%T"), (job.run_at - Time.now) / total_time * 100]
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_poll
    @poll = Poll.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def poll_params
    params.require(:poll).permit(:title, :active, :minutes, secret_code_attributes: [:value])
  end

  def admin!
    authenticate_user!

    redirect_to root_path, alert: "You are not authorized to this operation." unless current_user.admin?
  end
end
