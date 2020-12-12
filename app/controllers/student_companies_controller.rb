class StudentCompaniesController < ApplicationController
  before_action :authenticate_user!

  # skip_before_action :authenticate_user!, only: [:action_to_skip_here]

  before_action :set_student_company, only: [:show, :update, :destroy, :edit]

  def index
    @student_companies = StudentCompany.all
  end

  def fetch_current_user_companies
    @student_companies = StudentCompany.where(student_id: current_user.id)
  end

  def show
    @student_company
    @cash_management_table = CashManagementTable.find_by(student_company_id: @student_company.id)
    unless @cash_management_table.nil?
    @cash_in_histories = CashInHistory.where(cash_management_table_id: @cash_management_table.id)
    @cash_out_histories = CashOutHistory.where(cash_management_table_id: @cash_management_table.id)
    end
  end

  def new
    @student_company = StudentCompany.new

  end


  def edit
    @student_company
  end


  def create
    @student_company = StudentCompany.create(student_id: current_user.id, company_id: params['student_company']['company_id'])
    if @student_company.save
      flash[:notice] = "Student Company was successfully created"
      redirect_to @student_company
    else
      render 'new'
    end
  end

  def update
    if @student_company.update(student_params)
      redirect_to cash_management_table_path
    else
      render 'edit'
    end
  end

  def destroy
    if @student_company
      @student_company.destroy
      redirect_to fetch_current_user_companies_path
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
  # def student_company_params
  #   params.require(:student_company).permit(:company_id, :student_id)
  # end
end


