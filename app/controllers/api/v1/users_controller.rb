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


  def get_company_details
    student_companies = Company.where(student_id: @current_user.id)
    student_cash_management_tables = CashManagementTable.where(company_id: student_companies.pluck(:id))
    student_cash_in_history = CashInHistory.where(company_id: student_companies.pluck(:id))
    student_cash_out_history = CashOutHistory.where(company_id: student_companies.pluck(:id))
    render json: {user:@current_user, student_companies: student_companies,
                  student_cash_management_tables: student_cash_management_tables,
                  student_cash_in_history: student_cash_in_history,
                  student_cash_out_history: student_cash_out_history,

    }
  end

  # private
  #
  # def user_params
  #   params.permit(:email, :password)
  # end
end
