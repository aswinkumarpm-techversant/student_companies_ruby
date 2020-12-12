class CashOutHistoriesController < ApplicationController
  before_action :authenticate_user!

  # skip_before_action :authenticate_user!, only: [:action_to_skip_here]

  before_action :set_cash_out_history, only: [:show, :update, :destroy, :edit]

  def index
    @cash_out_histories = CashOutHistory.all
    render json: @cash_out_histories
  end

  def show
    render json: @cash_out_history
  end


  def new
    @cash_management_table_id = params[:cash_management_table_id]
    @cash_out_history = CashOutHistory.new

  end


  def edit
    @cash_management_table_id = params[:cash_management_table_id]
    @cash_out_history
  end




  def create
    @cash_out_history = CashOutHistory.new(cash_out_history_params)
    if @cash_out_history.save
      flash[:notice] = "CashOutHistory was successfully created"
      redirect_to fetch_current_user_companies_path
    else
      render 'new'
    end
  end

  def update
    if @cash_out_history.update(cash_out_history_params)
      redirect_to fetch_current_user_companies_path
    else
      render 'edit'
    end
  end

  def destroy
    if @cash_out_history
      @cash_out_history.destroy
      redirect_to fetch_current_user_companies_path
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

