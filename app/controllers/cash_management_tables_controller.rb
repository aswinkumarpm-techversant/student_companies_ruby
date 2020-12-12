class CashManagementTablesController < ApplicationController
  before_action :authenticate_user!

  # skip_before_action :authenticate_user!, only: [:action_to_skip_here]

  before_action :set_cash_management_table, only: [:show, :update, :destroy]

  def index
    student_companies = StudentCompany.where(student_id: current_user.id)
    @cash_management_tables = CashManagementTable.where(student_company_id: student_companies.pluck(:id))
    render json: @cash_management_tables

  end

  def show
    @cash_management_table
    @cash_in_histories = CashInHistory.where(cash_management_table_id: @cash_management_table.id)
    @cash_out_histories = CashOutHistory.where(cash_management_table_id: @cash_management_table.id)
  end

  def new
    @student_company_id = params[:student_company_id]
    @cash_management_table = CashManagementTable.new

  end

  def create
    @cash_management_table = CashManagementTable.new(cash_management_table_params)
    if @cash_management_table.save
      flash[:notice] = "CashManagement Table was successfully created"
      redirect_to @cash_management_table
    else
      render 'new'
    end
  end



  def update
    if @cash_management_table.update(cash_management_table_params)
      redirect_to @cash_management_table
    else
      render 'edit'
  end
  end

  def destroy
    if @cash_management_table
      @cash_management_table.destroy
      redirect_to fetch_current_user_companies_path
  end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cash_management_table
    @cash_management_table = CashManagementTable.find(params[:id])
  end

  # Only allow a trusted parameter “white list” through.
  def cash_management_table_params
    params.require(:cash_management_table).permit(:cash_in, :cash_out, :initial_cash, :student_company_id)
  end
end

