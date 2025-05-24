class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix
  respond_to :json
  before_action :authenticate_user!, only: [:destroy]

  def destroy
    user = User.find(current_user.id)
    if user.destroy
      render json: { status: 200, message: 'User deleted successfully.' }
    else
      render json: { status: 422, message: 'User could not be deleted.' }, status: :unprocessable_entity
    end
  end

  def respond_with(resource, _opts = {})    
    if request.method == "POST" && resource.persisted?
      render json: { message: "Signed up sucessfully.", data: resource }, status: :ok
    else
      render json: { message: "User couldn't be created successfully", errors: resource.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end
end
