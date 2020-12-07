class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    @user = User.new(sign_up_params)
    if @user.save
      token = JsonWebToken.encode({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: { errors: @user.errors }
    end
  end

  # def encode_token(payload)
  #   JWT.encode(payload, 's3cr3t')
  # end
  #
  # def auth_header
  #   # { Authorization: 'Bearer <token>' }
  #   request.headers['Authorization']
  # end
  #
  # def decoded_token
  #   if auth_header
  #     token = auth_header.split(' ')[1]
  #     # header: { 'Authorization': 'Bearer <token>' }
  #     begin
  #       JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
  #     rescue JWT::DecodeError
  #       nil
  #     end
  #   end
  # end
  #
  # def logged_in_user
  #   if decoded_token
  #     user_id = decoded_token[0]['user_id']
  #     @user = User.find_by(id: user_id)
  #   end
  # end
  #
  # def logged_in?
  #   !!logged_in_user
  # end
  #
  # def authorized
  #   render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  # end

  private

  def set_default_format
    request.format = :json
  end



  def sign_up_params
    params.permit(:first_name, :last_name, :role,:avatar, :avatar_cache, :email, :password, :password_confirmation)
  end
end