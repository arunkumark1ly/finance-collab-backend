class AuditLog < ApplicationRecord
  belongs_to :auditable, polymorphic: true
  belongs_to :changed_by, class_name: 'User'
end
