class JwtDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  # Ensure that the jti is unique
  validates :jti, presence: true, uniqueness: true
end
