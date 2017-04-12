class SecretCodesController < ApplicationController

  def check
    @secret_code = SecretCode.find_by_value params[:value]

    respond_to do |format|
      if !@secret_code
        format.html { redirect_to secret_codes_show_path, alert: 'There is no poll for your code.' }
        format.json { render json: @secret_code.errors, status: :unprocessable_entity }
      elsif !ip_check
        format.html { redirect_to secret_codes_show_path, alert: "Your ip #{@ip} has already voted." }
        format.json { render json: @secret_code.errors, status: :unprocessable_entity }
      elsif !active_check
        flash[:warning] = 'Poll for this code is not available yet.'
        format.html { redirect_to secret_codes_show_path }
        format.json { render json: @secret_code.errors, status: :unprocessable_entity }
      elsif @secret_code
        format.html { redirect_to new_poll_reply_path @secret_code.poll }
        format.json { render :show, status: :ok, location: new_poll_reply_path }
      else
        format.html { redirect_to secret_codes_show_path }
        format.json { render json: @secret_code.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  private

  def active_check
    @secret_code.poll.active?
  end

  def ip_check
    @ip = request.remote_ip
    Ip.where(:value => @ip, :poll_id => @secret_code.poll).empty?
  end

  def secret_codes_params
    params.permit(:value)
  end

end
