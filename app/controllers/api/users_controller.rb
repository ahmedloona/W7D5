class Api::UsersController < ApplicationController
  def create
    user = User.new
    user.username = user_params[:username]
    user.password = user_params[:password]
    debugger
    if user.save
      login(user)
      render :show
    else
      # error
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
