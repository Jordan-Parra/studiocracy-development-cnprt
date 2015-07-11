class UsersController < ApplicationController

  before_action :set_user, only: [
    :show,
    :edit,
    :update,
    :destroy
  ]

  
  def index
    @users = User.search_and_order(params[:search], params[:page])
  end

  def show
    @user = User.friendly.find(params[:id])
  end

  def edit
  end

  def update
    old_email = @user.email
    new_params = user_params.dup
    new_params[:email] = new_params[:email].strip

    @user.email = new_params[:email]
    @user.password = new_params[:password] if new_params[:password].strip.length > 0
    @user.password_confirmation = new_params[:password_confirmation] if new_params[:password_confirmation].strip.length > 0

    if current_user.id != @user.id
      @user.admin = new_params[:admin]=="0" ? false : true
      @user.locked = new_params[:locked]=="0" ? false : true
    end

    if @user.valid?
      @user.skip_reconfirmation!
      @user.save
      redirect_to admin_users_path, notice: "#{@user.email} updated."
    else
      flash[:alert] = "#{old_email} couldn't be updated."
      render :edit
    end
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  rescue
    flash[:alert] = "The user with an id of #{params[:id]} doesn't exist."
    redirect_to admin_users_path
  end

  def user_params
    params.require(:user).permit(
    :email,
    :password,
    :image,
    :password_confirmation,
    :admin,
    :locked,
    :first_name,
    :last_name,
    :city,
    :state,
    :zip_code,
    :bio,
    #omniauth:
    :uid,
    :provider,
    :stripeid
    )
  end

end
