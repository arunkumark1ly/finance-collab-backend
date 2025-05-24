class Api::V1::TeamsController < ApplicationController
  before_action :authenticate_user!  # Ensure the user is authenticated
  before_action :set_team, only: [:show, :update, :destroy]  # Find team for show, update, and destroy actions

  # Create a new team
  def create
    team = Team.new(team_params)
    team.users << current_user  # Add the current user as a member of the team

    if team.save
      render json: {
        status: { code: 201, message: 'Team created successfully.' },
        data: team
      }, status: :created
    else
      render json: {
        status: { code: 422, message: 'Team could not be created.' },
        errors: team.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # Show a specific team
  def show
    render json: {
      status: { code: 200, message: 'Team retrieved successfully.' },
      data: @team
    }, status: :ok
  end

  # List all teams for the current user
  def index
    teams = current_user.teams
    render json: {
      status: { code: 200, message: 'Teams retrieved successfully.' },
      data: teams
    }, status: :ok
  end

  # Update a team
  def update
    if @team.update(team_params)
      render json: {
        status: { code: 200, message: 'Team updated successfully.' },
        data: @team
      }, status: :ok
    else
      render json: {
        status: { code: 422, message: 'Team could not be updated.' },
        errors: @team.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # Delete a team
  def destroy
    if @team.destroy
      render json: { status: 200, message: 'Team deleted successfully.' }
    else
      render json: { status: 422, message: 'Team could not be deleted.' }, status: :unprocessable_entity
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)  # Adjust attributes as needed
  end
end
