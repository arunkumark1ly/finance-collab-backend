class Api::V1::InvitationsController < ApplicationController
  before_action :authenticate_user!

  def create
    team = Team.find(params[:team_id])
    email = params[:email]

    # Check if the user already exists
    user = User.find_by(email: email)

    begin
      if user
        # If the user exists, add them to the team
        TeamMembership.create!(user: user, team: team)
        render json: { message: "User added to the team." }, status: :ok
      else
        # If the user does not exist, create an invitation
        invitation = Invitation.create!(
          email: email,
          team: team,
          invited_by_id: current_user.id,
          token: SecureRandom.uuid
        )

        # Send invitation email (you'll need to implement this method)
        # InvitationMailer.send_invitation(invitation).deliver_now

        render json: { message: "Invitation sent." }, status: :created
      end
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    end
  end
end
