class AddStudentIdToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :student_id, :integer
  end
end
