class Api::V1::UsersController < ApplicationController

  def show
    user = User.select(:id, :username).find(params[:id])

    render json: user
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user.to_json(:only => [:id, :username]), status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
