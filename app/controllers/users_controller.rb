class UsersController < ApplicationController
  before_action :set_user

  def update
    authorize @user, :update?
    permitted = params.require(:user).permit(*policy(@user).update_permitted_params)
    @user.assign_attributes(permitted)

    if @user.save
      render json: { id: @user.id }, status: :ok
    else
      render json: { errors: @user.errors.to_hash(true) }, status: :unprocessable_entity
    end
  end

  private
  def set_user = @user = User.find(params[:id])
end
