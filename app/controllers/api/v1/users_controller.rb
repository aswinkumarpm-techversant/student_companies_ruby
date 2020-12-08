class Api::V1::UsersController < ApiController
  before_action :authenticate_request!, only: [:auto_login, :get_company_details]

  # REGISTER
  # def create
  #   @user = User.create(user_params)
  #   if @user.valid?
  #     token = encode_token({user_id: @user.id})
  #     render json: {user: @user, token: token}
  #   else
  #     render json: {error: "Invalid username or password"}
  #   end
  # end

  # LOGGING IN
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.valid_password?(params[:password])
      token = JsonWebToken.encode({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end


  def auto_login
    render json: @current_user
  end



  # private
  #
  # def user_params
  #   params.permit(:email, :password)
  # end
end
