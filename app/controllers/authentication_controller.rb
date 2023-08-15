class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user

  def login
    @user = User.find_by_email(params[:user][:email])
    verified_user_password = @user&.authenticate(params[:user][:password])

    if verified_user_password
      user_token = jwt_encode(user_id: @user.id)
      render json: {
        user: { id: @user.id, username: @user.username, email: @user.email }, token: user_token
      }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
