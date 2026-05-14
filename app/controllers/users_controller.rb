class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    @user.role = :owner
    if @user.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def user_params
      params.expect(user: [ :email_address, :password, :password_confirmation ])
    end
end
