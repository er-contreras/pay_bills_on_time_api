class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  before_action :find_user, only: %i[show destroy]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.with(user_params: @user).welcome_email.deliver_later
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    return if @user.update(user_params)

    render json: { errors: @user.errors.full_messages },
           status: :unprocessable_entity
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
