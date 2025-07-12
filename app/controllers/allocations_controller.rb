# app/controllers/allocations_controller.rb
class AllocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :prevent_admin_allocation

  def new
    @projects = Project.all
    @allocations = current_user.allocations.index_by(&:project_id)
  end

  def create
    allocations_params = params[:allocations] || {}
    total = allocations_params.values.map(&:to_i).sum

    if total > 1000
      flash.now[:alert] = "You cannot allocate more than $1,000."
      @projects = Project.all
      @allocations = current_user.allocations.index_by(&:project_id)
      render :new
      return
    end

    Allocation.transaction do
      allocations_params.each do |project_id, amount|
        allocation = current_user.allocations.find_or_initialize_by(project_id: project_id)
        allocation.amount = amount.to_i
        allocation.save!
      end
    end

    redirect_to allocation_path(current_user)
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.message
    @projects = Project.all
    @allocations = current_user.allocations.index_by(&:project_id)
    render :new
  end

  def show
    @allocations = current_user.allocations.includes(:project)
    @total = @allocations.sum(:amount)
  end

  private

  def prevent_admin_allocation
    if current_user.admin?
      redirect_to root_path, alert: "Admins cannot allocate budget to projects."
    end
  end
end
