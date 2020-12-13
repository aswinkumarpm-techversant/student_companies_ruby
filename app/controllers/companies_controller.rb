class CompaniesController < ApplicationController
  before_action :authenticate_user!

  # skip_before_action :authenticate_user!, only: [:action_to_skip_here]

  before_action :set_company, only: [:show, :update, :destroy, :edit]
  # GET /companies
  def index
    # @companies = Company.all
    @companies = Company.page params[:page]
  end
  # GET /companies/1
  def show
    @company
    @student_companies = StudentCompany.where(company_id: @company.id)
    @cash_management_tables = CashManagementTable.where(student_company_id: @student_companies.pluck(:id))
    unless @cash_management_tables.nil?
      @cash_in_histories = CashInHistory.where(cash_management_table_id: @cash_management_tables.pluck(:id))
      @cash_out_histories = CashOutHistory.where(cash_management_table_id: @cash_management_tables.pluck(:id))
    end
  end

  def new
    @company = Company.new

  end


  def edit
    @company
  end


  # POST /companies
  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:notice] = "Company was successfully created"
      redirect_to companies_path
    else
      render 'new'
    end
  end
  # PATCH/PUT /companies/1
  def update
    if @company.update(company_params)
      redirect_to companies_path
    else
      render 'edit'
    end

  end
  # DELETE /companies/1
  def destroy
    if @company
      @company.destroy
      redirect_to companies_path
    end

  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:id])
  end
  # Only allow a trusted parameter “white list” through.
  def company_params
    params.require(:company).permit(:name, :country, :currency, :student_id)
  end
end
