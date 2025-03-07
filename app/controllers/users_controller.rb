class UsersController < ApplicationController
  before_action :require_admin_or_leader

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "User was successfully updated."
      redirect_to @user
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence + "!"
      render :show, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.expect(user: [ :name, :email_address, :role ])
  end
end
