class Api::V1::StudentCompaniesController < ApiController
  before_action :authenticate_request!

  # skip_before_action :authenticate_user!, only: [:action_to_skip_here]

  before_action :set_student_company, only: [:show, :update, :destroy]

  def index
    @student_companies = StudentCompany.all
    render json: @student_companies
  end

  def show
    render json: @student_company
  end

  def create
    @student_company = StudentCompany.new(student_company_params)
    if @student_company.save
      render json: @student_company, status: :created
    else
      render json: @student_company.errors, status: 400
    end
  end

  def update
    if @student_company.update(student_params)
      render json: {message: "Student Company Updated Successfully"}, status: 200
    else
      render json: @student_company.errors, status: 400
    end
  end

  def destroy
    if @student_company
      @student_company.destroy
      render json: {message: "Student Company Deleted Successfully"}, status: 200
    else
      render json: {error: "Unable  to Delete"}, status: 400
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student_company
    @student_company = StudentCompany.find(params[:id])
  end

  # Only allow a trusted parameter “white list” through.
  def student_company_params
    params.require(:student_company).permit(:company_id, :student_id)
  end
end


