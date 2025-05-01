class StatusesController < ApplicationController
  include Filterable
  before_action :require_admin

  def index
    @statuses = Status.all

    @statuses = filter_by_status_name(@statuses)
    @statuses = filter_by_status_active(@statuses)
  end

  def new
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    if @status.save
      flash[:success] = "Status was successfully created."
      redirect_to statuses_path
    else
      flash.now[:error] = @status.errors.full_messages.to_sentence + "!"
      render :new, status: :unprocessable_entity
    end
  end

  def toggle_active
    @status = Status.find(params[:id])
    @status.update(active: !@status.active) # Toggles true/false
    flash[:success] = "Status updated successfully."
    redirect_to statuses_path
  end

  private
  def status_params
    params.expect(status: [ :name, :active ])
  end
end
