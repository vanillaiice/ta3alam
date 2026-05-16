class UsersController < ApplicationController
  before_action :authorize_owner

  def index
    @users = policy_scope(User)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(password: SecureRandom.hex(16)))
    if @user.save
      UsersMailer.invite(@user).deliver_later
      redirect_to users_path, notice: "#{@user.name} has been invited. A password setup email has been sent."
    else
      render :new, status: :unprocessable_content
    end
  end

  private
    def authorize_owner
      authorize User
    end

    def user_params
      params.expect(user: [ :email_address, :name, :role ])
    end
end
