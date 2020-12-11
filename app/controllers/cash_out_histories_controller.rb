class CashOutHistoriesController < ApplicationController
  before_action :authenticate_user!

  # skip_before_action :authenticate_user!, only: [:action_to_skip_here]

  before_action :set_cash_out_history, only: [:show, :update, :destroy]

  def index
    @cash_out_histories = CashOutHistory.all
    render json: @cash_out_histories
  end

  def show
    render json: @cash_out_history
  end

  def create
    @cash_out_history = CashOutHistory.new(cash_out_history_params)
    if @cash_out_history.save
      render json: @cash_out_history, status: :created
    else
      render json: @cash_out_history.errors, status: 400
    end
  end

  def update
    if @cash_out_history.update(cash_out_history_params)
      render json: {message: "Cash OUT History Updated Successfully"}, status: 200
    else
      render json: @cash_out_history.errors, status: 400
    end
  end

  def destroy
    if @cash_out_history
      @cash_out_history.destroy
      render json: {message: "Cash OUT History Deleted Successfully"}, status: 200
    else
      render json: {error:"Unable  to Delete" }, status: 400
    end

  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_cash_out_history
    @cash_out_history = CashOutHistory.find(params[:id])
  end
  # Only allow a trusted parameter “white list” through.
  def cash_out_history_params
    params.require(:cash_out_history).permit(:cogs_amount, :employees_amount, :services_amount, :operating_expenses_amount, :investments_amount, :cash_management_table_id)
  end
end

