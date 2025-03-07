class UsersController < ApplicationController
  before_action :require_admin_or_leader

  def index
    @users = User.all
  end

  def show
  end
end
