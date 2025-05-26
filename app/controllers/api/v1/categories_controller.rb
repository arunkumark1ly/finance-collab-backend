class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    categories = Category.all
    render json: categories, status: :ok
  end
end
