class AuditService
  def self.log(auditable:, action:, changed_by:, previous_data: nil, new_data: nil)
    AuditLog.create!(
      auditable: auditable,
      action: action,
      changed_by: changed_by,
      previous_data: previous_data,
      new_data: new_data
    )
  end
end
