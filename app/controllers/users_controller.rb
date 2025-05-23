class UsersController < ApplicationController
  include Filterable
  before_action :require_admin_or_leader

  def index
    @users = User.all
    @roles = @users.distinct.pluck(:role)

    @users = filter_by_user_role(@users)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User was successfully created."
      redirect_to @user
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence + "!"
      render :new, status: :unprocessable_entity
    end
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
    params.expect(user: [ :name, :email_address, :role, :password, :password_confirmation ])
  end
end
