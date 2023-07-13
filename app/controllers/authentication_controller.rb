class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user

  def login
    @user = User.find_by_email(params[:user][:email])
    if @user&.authenticate(params[:user][:password])
      token = jwt_encode(user_id: @user.id)
      render json: { user: @user.email, token: }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
