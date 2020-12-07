class Api::V1::CompaniesController < ApiController
  before_action :authenticate_request!

  # skip_before_action :authenticate_user!, only: [:action_to_skip_here]

  before_action :set_company, only: [:show, :update, :destroy]
  # GET /companies
  def index
    @companies = Company.all
    render json: @companies
  end
  # GET /companies/1
  def show
    render json: @company
  end
  # POST /companies
  def create
    @company = Company.new(company_params)
    if @company.save
      render json: @company, status: :created
    else
      render json: @company.errors, status: 400
    end
  end
  # PATCH/PUT /companies/1
  def update
    if @company.update(company_params)
      render json: {message: "Company Updated Successfully"}, status: 200
    else
      render json: @company.errors, status: 400
    end
  end
  # DELETE /companies/1
  def destroy
    if @company
      @company.destroy
      render json: {message: "Company Deleted Successfully"}, status: 200
    else
      render json: {error:"Unable  to Delete" }, status: 400
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
