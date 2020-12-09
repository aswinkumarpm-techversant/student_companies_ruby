class Api::V1::StudentCompaniesController < ApiController
  before_action :authenticate_request!

  # skip_before_action :authenticate_user!, only: [:action_to_skip_here]

  before_action :set_student_company, only: [:show, :update, :destroy]

  def index
    @student_companies = StudentCompany.all
    render json: @student_companies
  end

  def show
    render json: @student_company
  end

  def create
    @student_company = StudentCompany.new(student_company_params)
    if @student_company.save
      render json: @student_company, status: :created
    else
      render json: @student_company.errors, status: 400
    end
  end

  def update
    if @student_company.update(student_params)
      render json: {message: "Student Company Updated Successfully"}, status: 200
    else
      render json: @student_company.errors, status: 400
    end
  end

  def destroy
    if @student_company
      @student_company.destroy
      render json: {message: "Student Company Deleted Successfully"}, status: 200
    else
      render json: {error: "Unable  to Delete"}, status: 400
    end

  end

  def get_company_details
    student_companies = StudentCompany.where(student_id: params[:student_id], company_id: params[:company_id])
    student_cash_management_tables = CashManagementTable.find_by(student_company_id: student_companies.pluck(:id))
    student_cash_in_histories = CashInHistory.where(cash_management_table_id: student_cash_management_tables.id)
    student_cash_out_histories = CashOutHistory.where(cash_management_table_id: student_cash_management_tables.id)
    render json: {user:@current_user, student_companies: student_companies,
                  student_cash_management_tables: student_cash_management_tables,
                  student_cash_in_histories: student_cash_in_histories,
                  student_cash_out_histories: student_cash_out_histories,

    }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student_company
    @student_company = StudentCompany.find(params[:id])
  end

  # Only allow a trusted parameter “white list” through.
  def student_company_params
    params.require(:student_company).permit(:company_id, :student_id)
  end
end


