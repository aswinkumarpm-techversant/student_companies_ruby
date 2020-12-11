class CompaniesController < ApplicationController
  before_action :authenticate_user!

  # skip_before_action :authenticate_user!, only: [:action_to_skip_here]

  before_action :set_company, only: [:show, :update, :destroy, :edit]
  # GET /companies
  def index
    @companies = Company.all
  end
  # GET /companies/1
  def show
    @company
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
      redirect_to @company
    else
      render 'new'
    end
  end
  # PATCH/PUT /companies/1
  def update
    if @company.update(company_params)
      redirect_to @company
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
