class SecretCodesController < ApplicationController

  def check
    @secret_code = SecretCode.find_by_value params[:value]

    respond_to do |format|
      if !@secret_code
        format.html { redirect_to secret_codes_show_path, alert: 'К сожалению, не существует голосования с таким кодом.' }
        format.json { render json: @secret_code.errors, status: :unprocessable_entity }
      elsif !ip_check
        format.html { redirect_to secret_codes_show_path, alert: "Пользователь с IP #{@ip} уже голосовал. С одного IP можно голосовать только один раз." }
        format.json { render json: @secret_code.errors, status: :unprocessable_entity }
      elsif !active_check
        flash[:warning] = 'Голосование еще не запущено. Попробуйте позже.'
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
    respond_to do |format|
      format.html { redirect_to secret_codes_show_path }
      format.all { render status: :bad_request }
    end
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
