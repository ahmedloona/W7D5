class Api::SessionsController < ApplicationController

  def create()
    user = User.find_by_credentials(session_params[:username], session_params[:password])
    if user
      login(user)
    else
      # do some error stuff
    end
  end

  def destroy
    logout
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end

end
