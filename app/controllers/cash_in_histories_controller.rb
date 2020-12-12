class CashInHistoriesController < ApplicationController
  before_action :authenticate_user!

  # skip_before_action :authenticate_user!, only: [:action_to_skip_here]

  before_action :set_cash_in_history, only: [:show, :update, :destroy, :edit]

  def index
    @cash_in_histories = CashInHistory.all
    render json: @cash_in_histories
  end

  def show
    render json: @cash_in_history
  end

  def new
    @cash_in_history = CashInHistory.new

  end


  def edit
    @cash_management_table_id = params[:cash_management_table_id]
    @cash_in_history
  end

  def edit_cash_in_history
    @cash_management_table_id = params[:cash_management_table_id]
    @cash_in_history
  end


  def create
    @cash_in_history = CashInHistory.new(cash_in_history_params)
    if @cash_in_history.save
      flash[:notice] = "CashHistory was successfully created"
      redirect_to fetch_current_user_companies_path
    else
      render 'new'
    end
  end

  def update_cash_in_history
    if @cash_in_history.update(cash_in_history_params)
      redirect_to cash_management_table_path
    else
      render 'edit'
    end
  end

  def update
    if @cash_in_history.update(cash_in_history_params)
      redirect_to fetch_current_user_companies_path
    else
      render 'edit'
    end
  end

  def destroy
    if @cash_in_history
      @cash_in_history.destroy
      redirect_to fetch_current_user_companies_path
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

