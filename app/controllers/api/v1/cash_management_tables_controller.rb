class Api::V1::CashManagementTablesController < ApiController
  before_action :authenticate_request!

  # skip_before_action :authenticate_user!, only: [:action_to_skip_here]

  before_action :set_cash_management_table, only: [:show, :update, :destroy]

  def index
    @cash_management_tables = CashManagementTable.all
    render json: @cash_management_tables
  end

  def show
    render json: @cash_management_table
  end

  def create
    @cash_management_table = CashManagementTable.new(cash_management_table_params)
    if @cash_management_table.save
      render json: @cash_management_table, status: :created
    else
      render json: @cash_management_table.errors, status: 400
    end
  end

  def update
    if @cash_management_table.update(cash_management_table_params)
      render json: {message: "Cash Management Table Updated Successfully"}, status: 200
    else
      render json: @cash_management_table.errors, status: 400
    end
  end

  def destroy
    if @cash_management_table
      @cash_management_table.destroy
      render json: {message: "Cash Management Table Deleted Successfully"}, status: 200
    else
      render json: {error: "Unable  to Delete"}, status: 400
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

