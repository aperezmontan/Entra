class KeysController < ApplicationController
  before_action :require_login, only: [:show, :new, :edit, :delete]
  before_action :get_key, only: [:update, :used_at, :delete]
  def show

  end

  def new
    @key = Key.new
    respond_to do |format|
      if request.xhr?
        format.html { render :new, layout: false}
      else
        format.html { render :new }
      end
    end
  end

  def create
    new_key = Key.new(get_params)
    if new_key.save
      send_mail new_key
      flash[:success] = "New key created"
      redirect_to place_path(new_key.place)
    else
      flash[:error] = "Key could not be created :("
      redirect_to user_path(current_user)
    end
  end

  def edit

  end

  def update
    key = Key.find_by(id: params[:id])
    if key.update_attributes(get_params)
      flash[:success] = "Key has been updated!"
    else
      flash[:error] = "Key could not be updated :("
    end
    redirect_to :back
  end

  def used_at
    @key.used_at = Time.now if (params[:status] == 'opened')
    @key.save
    render :json => params
  end

  def delete

  end

  def find_guests_key_by_url
    @key = Key.find_by(secret_url: params[:hash])
  end

  private

  def get_params
    params.require(:key).permit(:place_id, :start_date, :guest_id, :end_date,:requested)
  end

  def send_mail key
    GuestMailer.buzzer_email(base_url, key, current_user).deliver_now
  end

  def get_key
    @key = Key.find_by(id: params[:id])
  end

end