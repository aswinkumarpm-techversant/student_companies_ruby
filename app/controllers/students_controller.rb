class StudentsController < ApplicationController
  before_action :authenticate_user!

  # skip_before_action :authenticate_user!, only: [:action_to_skip_here]

  before_action :set_student, only: [:show, :update, :destroy]
  # GET /students
  def index
    @students = Student.all
  end
  # GET /students/1
  def show
    @student
  end
  # POST /students
  def create
    @student = Student.new(student_params)
    if @student.save
      render json: @student, status: :created
    else
      render json: @student.errors, status: 400
    end
  end
  # PATCH/PUT /students/1
  def update
    if @student.update(student_params)
      render json: {message: "Student Updated Successfully"}, status: 200
    else
      render json: @student.errors, status: 400
    end
  end
  # DELETE /students/1
  def destroy
    if @student
      @student.destroy
      render json: {message: "Student Deleted Successfully"}, status: 200
    else
      render json: {error:"Unable  to Delete" }, status: 400
    end

  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end
  # Only allow a trusted parameter “white list” through.
  def student_params
    params.require(:student).permit(:first_name, :last_name, :role,:avatar, :avatar_cache, :email, :password, :password_confirmation)
  end
end

