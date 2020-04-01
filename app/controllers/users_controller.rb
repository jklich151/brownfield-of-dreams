class UsersController < ApplicationController
  def show

    # conn = Faraday.new(url: "https://api.github.com")

    # response = conn.get("/user/repos?access_token=#{ENV["Github_token_jenny"]}")
    # response_2 = conn.get("/user/following?access_token=#{ENV["Github_token_jenny"]}")
    # response_3 = conn.get("/user/followers?access_token=#{ENV["Github_token_jenny"]}")
    # @json = JSON.parse(response.body, symbolize_names: true)[1..5]
    # @json_2 = JSON.parse(response_2.body, symbolize_names: true)
    # @json_3 = JSON.parse(response_3.body, symbolize_names: true)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
