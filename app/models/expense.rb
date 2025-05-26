class Expense < ApplicationRecord
  belongs_to :team
  belongs_to :user
  belongs_to :category, optional: true  # Allow expenses to exist without a category initially
  has_many :audit_logs, as: :auditable, dependent: :destroy

  validates :amount, :description, :spent_on, presence: true
  validates :category, presence: true  # Ensure a category is associated if needed

  after_create :log_create_audit
  before_update :capture_previous_data
  after_update :log_update_audit
  before_destroy :log_destroy_audit

  attr_accessor :audit_user
  attr_accessor :category_name

  private

  def log_create_audit
    AuditService.log(
      auditable: self,
      action: 'create',
      changed_by: audit_user,
      new_data: audit_data
    )
  end

  def capture_previous_data
    @previous_data = audit_data
  end

  def log_update_audit
    return if previous_changes.except(:updated_at).blank?

    AuditService.log(
      auditable: self,
      action: 'update',
      changed_by: audit_user,
      previous_data: @previous_data,
      new_data: audit_data
    )
  end

  def log_destroy_audit
    AuditService.log(
      auditable: self,
      action: 'destroy',
      changed_by: audit_user,
      previous_data: audit_data
    )
  end

  def audit_data
    {
      amount: amount,
      description: description,
      spent_on: spent_on,
      category_name: category&.name,
      user_id: user.id,
      user_email: user.email
    }
  end
end
