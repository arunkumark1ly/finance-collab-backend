class Expense < ApplicationRecord
  belongs_to :team
  belongs_to :user
  has_many :audit_logs, as: :auditable, dependent: :destroy

  validates :amount, :description, :category, :spent_on, presence: true

  after_create :log_create_audit
  before_update :capture_previous_data
  after_update :log_update_audit
  before_destroy :log_destroy_audit

  attr_accessor :audit_user

  private

  def log_create_audit
    AuditService.log(
      auditable: self,
      action: 'create',
      changed_by: audit_user,
      new_data: self.attributes
    )
  end

  def capture_previous_data
    @previous_data = self.slice(*self.changed)
  end

  def log_update_audit
    return if previous_changes.except(:updated_at).blank?

    AuditService.log(
      auditable: self,
      action: 'update',
      changed_by: audit_user,
      previous_data: @previous_data,
      new_data: self.slice(*@previous_data.keys)
    )
  end

  def log_destroy_audit
    AuditService.log(
      auditable: self,
      action: 'destroy',
      changed_by: audit_user,
      previous_data: self.attributes
    )
  end
end
