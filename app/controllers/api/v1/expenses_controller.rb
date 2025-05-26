class Api::V1::ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team
  before_action :authorize_user!
  before_action :set_expense, only: [:show, :update, :destroy]

  def index
    @expenses = @team.expenses.includes(:user, :category).order(spent_on: :desc)
    render json: @expenses.as_json(include: [:user, :category])
  end

  def show
    render json: @expense.as_json(include: :user)
  end

  def create
    @expense = @team.expenses.new(expense_params.merge(user: current_user))
    @expense.audit_user = current_user

    # Handle category association
    if params[:expense][:category_id].present?
      @expense.category_id = params[:expense][:category_id]
    elsif params[:expense][:category_name].present?
      @expense.category = Category.find_or_create_by(name: params[:expense][:category_name])
    end

    if @expense.save
      # Uncomment the following line to enable ActionCable broadcasting
      # ActionCable.server.broadcast("team_#{@team.id}_expenses", @expense.as_json(include: :user))
      render json: @expense.as_json(include: :user), status: :created
    else
      render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @expense.audit_user = current_user

    if @expense.update(expense_params)
      render json: @expense.as_json(include: :user), status: :ok
    else
      render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.audit_user = current_user

    # Set the deleted_at timestamp instead of destroying the record
    @expense.deleted_at = Time.current

    if @expense.save
      render json: { message: 'Expense marked as deleted successfully.' }, status: :ok
    else
      render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def audit_trail
    # Find the expense
    @expense = @team.expenses.find(params[:id])

    # Check if the user is authorized to view the expense
    authorize_user!

    # Fetch the audit logs related to the expense
    audit_logs = AuditLog.where(auditable: @expense).includes(:changed_by)

    # Prepare the response with category name
    audit_logs_with_category = audit_logs.map do |log|
      log_data = log.as_json(include: { changed_by: { only: [:id, :email, :name] } })
      log_data['category_name'] = log.auditable.category&.name  # Add category name to the log data
      log_data
    end

    # Return the audit logs in the response, including user information and category name
    render json: audit_logs_with_category, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Expense not found.' }, status: :not_found
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_expense
    @expense = @team.expenses.find(params[:id])
  end

  def authorize_user!
    head :forbidden unless @team.users.include?(current_user)
  end

  def expense_params
    params.require(:expense).permit(:amount, :description, :category_id, :category_name, :spent_on)
  end
end
