class Api::V1::CashInHistoriesController < ApiController
  before_action :authenticate_request!

  # skip_before_action :authenticate_user!, only: [:action_to_skip_here]

  before_action :set_cash_in_history, only: [:show, :update, :destroy]

  def index
    @cash_in_histories = CashInHistory.all
    render json: @cash_in_histories
  end

  def show
    render json: @cash_in_history
  end

  def create
    @cash_in_history = CashInHistory.new(cash_in_history_params)
    if @cash_in_history.save
      render json: @cash_in_history, status: :created
    else
      render json: @cash_in_history.errors, status: 400
    end
  end

  def update
    if @cash_in_history.update(cash_in_history_params)
      render json: {message: "Cash IN History Updated Successfully"}, status: 200
    else
      render json: @cash_in_history.errors, status: 400
    end
  end

  def destroy
    if @cash_in_history
      @cash_in_history.destroy
      render json: {message: "Cash IN History Deleted Successfully"}, status: 200
    else
      render json: {error:"Unable  to Delete" }, status: 400
    end

  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_cash_in_history
    @cash_in_history = CashInHistory.find(params[:id])
  end
  # Only allow a trusted parameter “white list” through.
  def cash_in_history_params
    params.require(:cash_in_history).permit(:revenues_amount, :equity_amount, :convertible_note_amount, :bank_debt_amount, :other_amount, :cash_management_table_id)
  end
end

